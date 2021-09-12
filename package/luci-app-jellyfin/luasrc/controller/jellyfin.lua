module("luci.controller.jellyfin", package.seeall)

function index()
	
	entry({'admin', 'services', 'jellyfin'}, alias('admin', 'services', 'jellyfin', 'client'), _('Jellyfin'), 10).dependent = true -- 首页
	entry({"admin", "services", "jellyfin",'client'}, cbi("jellyfin/status", {hideresetbtn=true, hidesavebtn=true}), _("Jellyfin"), 20).leaf = true
    entry({'admin', 'services', 'jellyfin', 'script'}, form('jellyfin/script'), _('Script'), 20).leaf = true -- 直接配置脚本

	entry({"admin", "services", "jellyfin","status"}, call("container_status"))
	entry({"admin", "services", "jellyfin","stop"}, call("stop_container"))
	entry({"admin", "services", "jellyfin","start"}, call("start_container"))
	entry({"admin", "services", "jellyfin","install"}, call("install_container"))
	entry({"admin", "services", "jellyfin","uninstall"}, call("uninstall_container"))
end

local sys  = require "luci.sys"
local uci  = require "luci.model.uci".cursor()
local keyword  = "jellyfin"
local port = tonumber(uci:get_first(keyword, keyword, "port"))
local util  = require("luci.util")
local container_id = util.trim(util.exec("docker ps -aqf'name='"..keyword.."''"))

function container_status()

	local status = {
		docker_install = (sys.call("docker -v' >/dev/null") ~= 0),
		running = (sys.call("pidof '"..keyword.."' >/dev/null") == 0),
		port = (port or 8096),
		container_id = container_id,
		container_install = (string.len(container_id) > 0)
	}

	luci.http.prepare_content("application/json")
	luci.http.write_json(status)
end

function stop_container()
	container_id = luci.http.formvalue('container_id')
	util.exec("docker stop '"..container_id.."'")
	container_status()
end

function start_container()
	container_id = luci.http.formvalue('container_id')
	util.exec("docker start '"..container_id.."'")
	container_status()
end

function install_container()
	luci.sys.call('sh /usr/share/mycbi/mycbi.sh')
	container_status()
end

function uninstall_container()
	container_id = luci.http.formvalue('container_id')
	util.exec("docker container rm '"..container_id.."'")
	container_status()
end

-- 总结：
-- docker是否安装
-- 容器是否安装
-- 缺少在lua和htm中运行命令的方法
-- 获取容器id docker ps -aqf'name=jellyfin'
-- 启动容器 docker start 78a8455e6d38
-- 停止容器 docker stop 78a8455e6d38


--[[
todo
网络请求提示框
 --]]