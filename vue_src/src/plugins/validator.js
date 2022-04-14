import { directives, validator } from "@/cmmn/validator.js";
import Vue from "vue";

const plugin = {
  install(Vue) {
    Vue.directive("validate", directives.validate);

    Vue.mixin({
      data() {
        return { errorBag: {} };
      },
      computed: {
        $errors() {
          const errorBag = this.errorBag || {};

          return {
            has(key) {
              return !!errorBag[key];
            },
            first(key) {
              return errorBag[key][0];
            },
          };
        },
        $validator() {
          const context = this;

          return {
            validateAll() {
              for (const key of validator.validates.keys()) {
                const errors = validator.validate(key, context[key]);

                if (errors.length) context.$set(context.errorBag, key, errors);
                else context.$delete(context.errorBag, key);
              }
            },
          };
        },
      },
    });
  },
};

Vue.use(plugin);
export default plugin;
