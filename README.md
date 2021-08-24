# Version Check Action

This action uses the GitHub API to check a given version against the tags currently existing on the repository in
order to determine if a new release should be created.

# Usage

```yaml
- uses: DrizlyInc/version-check-action@v0.2.0
  id: check-version
  with:

    # The version to check against the current tags on the repository
    version: v1.0.0

    # Can be provided in place of `version`, path to a file containing
    # the version which should be checked
    version_file: ./version

    username: ${{ github.actor }}
    token: ${{ github.token }}

- name: Release
  if: ${{ steps.check-version.outputs.new-version == 'true' }}
  run: echo "This is where I would release"
```

# Releasing

To generate a new release of this action, simply update the version tag on the image designation at the end of the [action metadata file](./action.yml). The github workflow will automatically publish a new image and create a release upon merging to main.

# License

The contents of this repository are released under the [GNU General Public License v3.0](LICENSE)
