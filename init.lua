local function get_formspec(txt)
	local news_file = io.open(minetest.get_worldpath().."/"..tostring(txt), "r")
	local news_fs = 'size[12,8.25]'..
		"button_exit[-0.05,7.8;2,1;exit;Close]"
	if news_file then
		local news = news_file:read("*a")
		news_file:close()
		news_fs = news_fs.."textarea[0.25,0;12.1,9;news;;"..news.."]"
	else
		news_fs = news_fs.."textarea[0.25,0;12.1,9;news;;This newspaper is blank.]"
	end
	return news_fs
end

newspaper = {}
function newspaper.register_newspaper(book,desc,texture,txt)
    texture = texture or "default_book_written.png"
    texture = tostring(texture)
    txt = txt or "nil_newspaper.txt"
    txt = tostring(txt)
    desc = desc or "Newspaper "..txt
    if book then
        minetest.register_craftitem(book,{
            description = desc,
            inventory_image = texture,
            on_use = function(itemstack, user, pointed_thing)
                name = user:get_player_name()
                minetest.show_formspec(name, desc, get_formspec(txt))
            end,
        })
        minetest.log("action", "[Newspaper] Registered newspaper: "..book)
    else
        minetest.log("error", "[Newspaper] Can't register newspaper with no id: "..txt)
    end
end
