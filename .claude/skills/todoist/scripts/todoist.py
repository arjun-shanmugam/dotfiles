#!/usr/bin/env python3
"""Todoist REST API v1 helper for the /todoist skill.

No third-party dependencies (stdlib urllib only).

Token resolution order:
  1. TODOIST_API_TOKEN environment variable
  2. ~/.config/todoist-nvim-dev/token

Base URL: https://api.todoist.com/api/v1

Subcommands:
  find "<name>"          Match open tasks by content (client-side). The server
                         search filter is unreliable, so we fetch all open tasks
                         (paginated) and match locally.
  tree <id>              Print a task's content + description, then all
                         descendant subtasks with their descriptions, indented.
  comments <id>          List existing comments on a task.
  comment <id> "<text>"  Post a comment on a task.
  complete <id>          Close (complete) a task.

Exit codes for `find`: 0 = exactly one match, 3 = no match, 4 = multiple matches.
All other errors exit 1.
"""

import json
import os
import sys
import urllib.error
import urllib.parse
import urllib.request

BASE = "https://api.todoist.com/api/v1"
TOKEN_FILE = os.path.expanduser("~/.config/todoist-nvim-dev/token")


def load_token():
    token = os.environ.get("TODOIST_API_TOKEN")
    if token:
        return token.strip()
    try:
        with open(TOKEN_FILE) as f:
            return f.read().strip()
    except OSError:
        sys.exit(
            "error: no Todoist token found. Set TODOIST_API_TOKEN or create "
            + TOKEN_FILE
        )


def request(method, path, token, query=None, body=None):
    url = BASE + path
    if query:
        url += "?" + urllib.parse.urlencode(query)
    data = None
    headers = {"Authorization": "Bearer " + token}
    if body is not None:
        data = json.dumps(body).encode()
        headers["Content-Type"] = "application/json"
    req = urllib.request.Request(url, data=data, headers=headers, method=method)
    try:
        with urllib.request.urlopen(req) as resp:
            raw = resp.read().decode()
            return json.loads(raw) if raw else {}
    except urllib.error.HTTPError as e:
        detail = e.read().decode(errors="replace")
        sys.exit("error: Todoist API {} on {} {}: {}".format(e.code, method, path, detail))
    except urllib.error.URLError as e:
        sys.exit("error: request failed for {} {}: {}".format(method, path, e))


def fetch_all_tasks(token, query=None):
    """Fetch all open tasks, following next_cursor pagination."""
    results = []
    cursor = None
    while True:
        q = dict(query or {})
        if cursor:
            q["cursor"] = cursor
        data = request("GET", "/tasks", token, query=q or None)
        page = data.get("results", []) if isinstance(data, dict) else (data or [])
        results.extend(page)
        cursor = data.get("next_cursor") if isinstance(data, dict) else None
        if not cursor:
            break
    return results


def cmd_find(token, name):
    tasks = fetch_all_tasks(token)
    needle = name.strip().lower()
    exact = [t for t in tasks if t.get("content", "").strip().lower() == needle]
    matches = exact if exact else [
        t for t in tasks if needle in t.get("content", "").lower()
    ]
    if not matches:
        print("NO_MATCH")
        sys.exit(3)
    if len(matches) > 1:
        print("MULTIPLE ({})".format(len(matches)))
        for t in matches:
            print("{}\t{}".format(t["id"], t.get("content", "")))
        sys.exit(4)
    t = matches[0]
    print("MATCH")
    print("{}\t{}".format(t["id"], t.get("content", "")))
    sys.exit(0)


def _print_task(token, task, depth):
    indent = "  " * depth
    print("{}- [{}] {}".format(indent, task["id"], task.get("content", "")))
    desc = (task.get("description") or "").strip()
    if desc:
        for line in desc.splitlines():
            print("{}    {}".format(indent, line))
    children = request("GET", "/tasks", token, query={"parent_id": task["id"]})
    kids = children.get("results", []) if isinstance(children, dict) else (children or [])
    for child in kids:
        _print_task(token, child, depth + 1)


def cmd_tree(token, task_id):
    task = request("GET", "/tasks/{}".format(task_id), token)
    _print_task(token, task, 0)


def cmd_comments(token, task_id):
    data = request("GET", "/comments", token, query={"task_id": task_id})
    items = data.get("results", []) if isinstance(data, dict) else (data or [])
    if not items:
        print("[]")
        return
    for c in items:
        print("{}  {}".format(c.get("posted_at", ""), c.get("content", "")))
        print("---")


def cmd_comment(token, task_id, text):
    request("POST", "/comments", token, body={"task_id": task_id, "content": text})
    print("comment posted to {}".format(task_id))


def cmd_complete(token, task_id):
    request("POST", "/tasks/{}/close".format(task_id), token)
    print("completed {}".format(task_id))


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    token = load_token()
    cmd = argv[1]
    args = argv[2:]
    if cmd == "find" and len(args) == 1:
        cmd_find(token, args[0])
    elif cmd == "tree" and len(args) == 1:
        cmd_tree(token, args[0])
    elif cmd == "comments" and len(args) == 1:
        cmd_comments(token, args[0])
    elif cmd == "comment" and len(args) == 2:
        cmd_comment(token, args[0], args[1])
    elif cmd == "complete" and len(args) == 1:
        cmd_complete(token, args[0])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
