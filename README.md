# halloumi-systems-management Cookbook

> This repository is intentionally made publicly available so that it is easily
> accessible from everywhere.

This cookbook is used to apply emergency security patches on all our AMIs without having to update all versions of other cookbooks in use.

Please:
  * Never pin this cookbook to a specific version in your Berksfile!
  * Always update to the latest version of this cookbook when making changes to an AMI.

## Usage:

Add the following to the `packer/<name>/Berksfile`:

```ruby
cookbook 'halloumi-systems-management',
  git: 'https://github.com/sentiampc/halloumi-systems-management-cookbook.git'
```

Add `recipe[halloumi-systems-management]` to the top of the runlist in `packer/<name>/attributes.json`:

```json
{
  ...,
  "run_list": [
    "recipe[halloumi-systems-management]",
    ...
  ],
  ...
}
```

Run `berks update` from `packer/<name>/`.
