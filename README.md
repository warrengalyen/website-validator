# Validate website HTML & CSS, check links & resources

A command-line website validator for Linux, Mac & Windows, which can spider through a website,
validating all HTML & CSS against W3C spec, check the existence of all assets (images, css, fonts, etc),
and verify outbound links.

## Features

- Check a single URL, to a certain depth, or an entire website
- HTML & CSS validation using (default) the [Nu Html Checker](https://validator.w3.org/)
- Detect & checks linked assets from HTML & linked CSS (fonts, favicons, images, videos, etc)
- Detect mixed content (HTTPS => HTTP) for linked assets (fonts, images, CSS, JS etc)
- Verify outbound links (to external websites)
- Summary report or errors (& optionally HTML/CSS warnings)
- Obeys `robots.txt` (can be ignored)

## Usage options

```shell
Usage: website-validator [options] <url>

Options:
  -a, --all                recursive, follow all internal links (default single URL)
  -d, --depth int          crawl depth ("-a" will override this)
  -o, --outbound           check outbound links (HEAD only)
      --html               validate HTML
      --css                validate CSS
  -i, --ignore string      ignore URLs, comma-separated, wildcards allowed (*.jpg,example.com)
  -n, --no-robots          ignore robots.txt (if exists)
  -r, --redirects          treat redirects as errors
  -w, --warnings           display validation warnings (default errors only)
  -f, --full               full scan (same as "-a -r -o --html --css")
  -t, --threads int        number of threads (default 5)
      --timeout int        timeout in seconds (default 10)
      --validator string   Nu Html validator (default "https://validator.w3.org/nu/")
  -u, --update             update to latest release
  -v, --version            show app version
```
## Examples
- `website-validator https://example.com/` - scan URL, verify all direct assets & links
- `website-validator https://example.com/ --css --html` - scan URL, verify all direct assets & links, validate HTML & CSS
- `website-validator https://example.com/ -a` - scan entire site, verify assets & links
- `website-validator https://example.com/ --css --html -d 2` - scan site to a depth of 2 internal links, verify assets & links, validate HTML and CSS
- `website-validator https://example.com/ -a -o` - scan entire site, verify all assets, verify outbound links
- `website-validator https://example.com/ -f` - scan entire site, verify all assets, verify outbound links, validate HTML & CSS

## Installing
Download the [latest binary release](https://github.com/warrengalyen/website-validator/releases/latest) for your system,
or build from source `go get -u github.com/warrengalyen/website-validator`(go >= 1.23 required)

### Robots.txt

By default, website-validator obeys `Disallow` rules in `robots.txt` if it exists. You can optionally skip this by adding `-n` to your runtime flags. To add specific rules for just the validator, you can target it specifically with `User-agent: website-validator`, eg:

```
User-agent: website-validator
Disallow: /assets/Products/*
```