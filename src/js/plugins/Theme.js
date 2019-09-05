const bg = (val) => {
  if (val === null) {
    return 'background-color: inherit'
  }

  if (typeof val === "string") {
    return `background-color: ${val}`
  }

  if (typeof val === "object") {
    return `background-image: linear-gradient(${val.direction||'to bottom'}, ${val.colors.join(",")})`
  }
}

export default {
  install: (vue) => {
    vue.prototype.$bg = bg
  }
};
