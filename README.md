# Uncraft
Craft CMS starter template with a minimalist Webpack config that includes Vue and Tailwind


## Getting Started
Below is a list of tools, resources, and dependencies that were used when building this project.

- [Craft 3](https://docs.craftcms.com/v3/)
- [Twig 2](https://twig.symfony.com/doc/2.x/)
- [Vue 2](https://vuejs.org/)
- [Tailwind](https://tailwindcss.com/)
- [Webpack](https://webpack.js.org/)

## Install
> You'll need [composer](https://getcomposer.org/) and [npm](https://www.npmjs.com/) to collaborate on this project.

##### Step 1 (clone repository)

```bash
git clone git@github.com:selvinortiz/uncraft.git

cd uncraft
```

##### Step 2 (install all dependencies)
```bash
composer i && npm i
```

##### Step 3 (configure Craft and your environment)

```bash
# Mac/Linux
# From project root
./craft setup

# May need to add executable permission
chmod +x craft
```

##### Step 4 (update package.json scripts)
Once you've completed the setup, you should update `package.json > scripts` to match your environment.

Specifically, you should update `{http://yoursiteurl.test}` to your local site URL if you want to use BrowserSync.

```bash
npm run start:sync
```

---

_More information coming soon..._
