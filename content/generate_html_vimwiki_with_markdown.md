Title: Generate HTML when Using Markdown in Vimwiki
Date: 2023-09-02
Category: Computer
Slug: generate_html_when_using_markdown_in_vimwiki
Author: John Nduli
Status: published


I [moved to `markdown`]({filename}/migrate_vimwiki_from_wiki_to_markdown.md) in
vimwiki but couldn't generate html. `VimwikiAll2HTML` only supported vimwiki
syntax. I explored static site generators looking for one that:

- didn't require moving my files and folders.
- didn't need a lot of configuration to set up.

I tested out [`mkdocs`](https://www.mkdocs.org/),
[`zola`](https://www.getzola.org/), [`docusaurus`](https://docusaurus.io/) and
[`vitepress`](https://vitepress.dev/) and only `vitepress` met both conditions.
It also worked out the box and I liked the default theme.

```bash
npm install -D vitepress
npx vitepress init
```

Note:

1. This works with `"vitepress": "^1.0.0-beta.3"` in my `package.json`.
2. This overrides `index.md`, so have a back up. I used git to restore it.


I generated the hmtl using:

```bash
npx run docs:build
```

The sidebars didn't look great though, and I used
[vitepress-plugin-auto-sidebar](https://github.com/JonathanSchndr/vitepress-plugin-auto-sidebar/tree/main)
to set this to by my folders. It's config looks like:

```javascript
sidebar: getSidebar({ contentRoot: '/', contentDirs: ['team'], collapsible: true, collapsed: true })
```

and this forced me to set up a long list of contentDirs. I instead used an
`ignore list` and generated my `contentDirs` from code with:

```javascript
const EXCLUDE_DIRS: string[] = ['node_modules', 'diary', 'scripts'];
const CONTENT_ROOT = '/';

function getSideBarFolders(): string[] {
  var content_root = path.join(process.cwd(), CONTENT_ROOT)
  return fs.readdirSync(content_root, {withFileTypes: true})
           .filter(f => f.isDirectory() && !f.name.startsWith('.') && !EXCLUDE_DIRS.includes(f.name))
           .map(f => f.name)
           .sort();
}
```

changing the plugin's config to:

```javascript
sidebar: getSidebar({ contentRoot: CONTENT_ROOT, contentDirs: getSideBarFolders(), collapsible: true, collapsed: true }),
```

I added a `post-commit` hook that would update my vimwiki site any time I
changed my wiki:

```
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"
npm run docs:build
rsync --recursive --archive --update --verbose --compress -P .vitepress/dist/ user@ip:/path/to/folder
```
