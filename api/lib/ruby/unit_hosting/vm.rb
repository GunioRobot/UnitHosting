#!/usr/bin/env ruby
# vim:set fileencoding=utf-8:
require 'unit_hosting/base.rb'

module UnitHosting
  class Vm < Base
    def load_key(file)
      File::open(file) do |f|
        xml = f.read
        doc = REXML::Document.new(xml)
        @instance_id = doc.elements['/server/instance_id'].text
        @api_key = doc.elements['/server/key'].text
      end
    end
    def reboot
      server_call("vm.reboot")
    end
    def start
      server_call("vm.start")
    end
    def shutdown
      server_call("vm.shutdown")
    end
    def power_off
      server_call("vm.powerOff")
    end
    def destroy
      server_call("vm.destroy")
    end
    def status?
      server_call("vm.getStatus")
    end
    def memory_unit_size size
      server_call("vm.setMemoryUnitSize",{"size" => size})
    end
    def cpu_unit_num num
      server_call("vm.setCpuUnitNum",{"num" => num})
    end
    def memory_unit_size?
      server_call("vm.getMemoryUnitSize")
    end
    def cpu_unit_num?
      server_call("vm.getCpuUnitNum")
    end
  end
end


if $0 == __FILE__
  vm = UnitHosting::Vm.new
  vm.load_key("/Users/tumf/Downloads/tumf-vm-91.key")
  pp vm.status?
  vm.reboot
end


