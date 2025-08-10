;extends

(block_mapping_pair
  value: (block_node
    (block_scalar 
      (comment) @injection.language
    ) @injection.content
  )
  (#gsub! @injection.language "^#%s*" "")
  (#gsub! @injection.content "^[^%c]*%c" ""))