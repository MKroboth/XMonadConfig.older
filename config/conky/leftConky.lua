 conky.config = {
    background = true,
    out_to_console = true,
    out_to_x = false,
    update_interval = 1
 }
 conky.text = [[CPU(${execi 8 sensors | grep -A 1 'Package id 0' | cut -c16-23 | head -1}) ${cpu cpu0}%(${execi 8 sensors | grep -A 1 'Core 0' | cut -c16-23 | head -1}) ${cpu cpu1}%(${execi 8 sensors | grep -A 1 'Core 1' | cut -c16-23 | head -1}) ${cpu cpu2}%(${execi 8 sensors | grep -A 1 'Core 2' | cut -c16-23 | head -1}) ${cpu cpu3}%(${execi 8 sensors | grep -A 1 'Core 3' | cut -c16-23 | head -1})]]
