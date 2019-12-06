# LHCI Dockerfile

Dockerfile for running the [lighthouse-ci cli](https://github.com/GoogleChrome/lighthouse-ci).

## no-sandbox
You'll receive an error when running commands like `lhci collect` or `lhci autorun` that depend on Chrome Headless. One workaround is setting chromeFlags in Lighthouse when running said commands.

```bash
--collect.settings.chromeFlags=--no-sandbox
```
