Triggers = {}

CollectionsUsed = { 17 }
Collection = 17
Bitmap = 7

function Triggers.init()
    for poly in Polygons() do
        assign_texture(poly.floor)
        assign_texture(poly.ceiling)

        for side in poly:sides() do
            local opposite = nil
            local adjacent = side.polygon
            if side.primary and side.type == "full" then
                local line = side.line

                if line.counterclockwise_polygon == adjacent and line.clockwise_polygon ~= nil then
                    opposite = line.clockwise_polygon
                elseif line.clockwise_polygon == adjacent and line.counterclockwise_polygon ~= nil then
                    opposite = line.counterclockwise_polygon
                end
            end
            if opposite == nil or opposite.floor.z > adjacent.ceiling.z or opposite.ceiling.z < adjacent.floor.z then
                assign_texture(side.primary)
            end

            if side.type == "split" and side.secondary then
                assign_texture(side.secondary)
            end

            if not side.transparent.empty then
                assign_texture(side.transparent)
            end
        end
    end
end

function assign_texture(surface)
    if surface.texture_index > 4 and surface.transfer_mode ~= "landscape" then
        surface.collection = Collection
        surface.texture_index = Bitmap
    end
end