# Spina Blocks

Reusable content blocks for Spina CMS! Create a block of content, and then add it
to any template you like, so footers and common reusable blocks can be readily
reused across the site.

# Usage

Add the gem to your gemfile:

`gem 'spina-blocks'`

Bundle away. Now you need to run the migrations to create the Blocks, parts, and
translations. The good news is that Spina is so open, these work in much the same
way as pages. As a result, you can define the same parts for a template as anywhere
else, and the system just works.

Spina is really good like that.

Register the template, and add some blocks into your template:

```
::Spina::Theme.register do |theme|

  # ...

  theme.plugins = ['blocks']

  theme.blocks_parts = [{
    name:           'text',
    title:          'Text',
    partable_type:  'Spina::Text'
  }]

  theme.blocks_templates = [{
    name:       'block',
    title:      'Default Block',
    block_parts: ['text']
  }]

  # ...
end
```

You can now create a block of this type in you CMS. Assign it a slug
(under 'Advanced') in the content pane, and add to your template:

```
= render_block 'footer'
```

That's it! If the block isn't published, we don't render anything. So you can
happily remove them for a bit.

Future release will probably make it possible to assign the block with a new
type.

# Technical Stuff

The blocks are heavily based on Pages, in fact their controller code is
basically stolen from SpinaCMS core. This means that the `BlockPart` we use is
also a version of `PagePart`, beyond that it uses all the standard Spina
components to work.
