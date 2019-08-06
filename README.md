# ModCore™️
A Craft CMS starter project with a minimalist Webpack config that includes Vue and Tailwind.

## Getting Started
Below is a list of tools, resources, and dependencies that were used when building this project.

- [Craft 3](https://docs.craftcms.com/v3/)
- [Twig 2](https://twig.symfony.com/doc/2.x/)
- [Vue 2](https://vuejs.org/)
- [Tailwind](https://tailwindcss.com/)
- [Webpack](https://webpack.js.org/)

## Requirements
> You'll need [composer](https://getcomposer.org/) and [npm](https://www.npmjs.com/) to collaborate on this project.

#### 1. Clone repository

```bash
git clone git@bitbucket.org:modcreative/wayfinding-core.git

cd wayfinding-core
```

#### 2. Install dependencies

```bash
composer i && npm i
```

##### 3. Configure Craft

```bash
# mac/linux only
# add executable permission
chmod +x craft

# run setup through Craft CLI
./craft setup
```

#### 4. Update build scripts
Once you've completed the setup, you should update `package.json > scripts` to match your environment.

Specifically, you should update `{http://yoursiteurl.test}` to your local site URL if you want to use BrowserSync.

```bash
npm run start:sync
```

---

#### Note
> This is a _work in progress_, if you spot any typos or feel you can contribute to this project, PRs are welcomed 😎
