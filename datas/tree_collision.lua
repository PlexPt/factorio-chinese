local enable = settings.startup["chinese-tree-enable"].value
if enable then
    -- 减小树木碰撞
    for _, tree in pairs(data.raw["tree"]) do
        tree.collision_box = { { -0.05, -0.05 }, { 0.05, 0.05 } }
    end
end

