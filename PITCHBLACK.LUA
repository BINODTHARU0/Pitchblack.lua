-- Sword Kill Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local SwordName = "ClassicSword" -- Replace with the correct sword name
local Friends = {} -- Store friend UserIds

-- Get all friends
for _, friend in ipairs(Players:GetFriendsAsync(LocalPlayer.UserId)) do
    Friends[friend.Id] = true
end

-- Debug: Notify script is running
print("Script loaded successfully!")

-- Function to kill non-friends
local function killNonFriends()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not Friends[player.UserId] then
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid:TakeDamage(100) -- Kill the player
                print("Killed player:", player.Name)
            end
        end
    end
end

-- Listen for Sword Equip
Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and child.Name == SwordName then
        print("Sword equipped:", child.Name)
        -- Start killing loop
        while child.Parent == Character do
            killNonFriends()
            wait(0.1)
        end
        print("Sword unequipped")
    end
end)
