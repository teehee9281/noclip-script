      _G.infinjump = not _G.infinjump

      if _G.infinJumpStarted == nil then
         -- Ensures this only runs once to save resources
         _G.infinJumpStarted = true

         -- Notifies readiness
         game.StarterGui:SetCore("SendNotification", {Title="UniversalHub"; Text="Infinite jump is ready!"; Duration=5;})

         -- The actual infinite jump
         local plr = game:GetService('Players').LocalPlayer
         local m = plr:GetMouse()
         m.KeyDown:connect(function(k)
            if _G.infinjump then
               if k:byte() == 32 then
                  humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
                  humanoid:ChangeState('Jumping')
                  wait()
                  humanoid:ChangeState('Seated')
               end
            end
         end)
      end
