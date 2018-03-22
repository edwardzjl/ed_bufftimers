
local addonName, addon = ...
local cfg = {}
addon.cfg = cfg
----------------------------------------------------------------------------------------------------
--[[frame settings]]
--[[buff settings]]
cfg.PlayerBuffIconSize = 25
cfg.PlayerBuffIconOffsetX = 200
cfg.PlayerBuffIconOffsetY = 180

cfg.PlayerDebuffIconSize = 30
cfg.PlayerDebuffIconOffsetX = 0
cfg.PlayerDebuffIconOffsetY = -30

cfg.TargetBuffIconSize = 25
cfg.TargetBuffIconOffsetX = -15
cfg.TargetBuffIconOffsetY = 5

cfg.FocusBuffIconSize = 25
cfg.FocusBuffIconOffsetX = -15
cfg.FocusBuffIconOffsetY = 5

cfg.PetBuffIconSize = 20
cfg.PetBuffIconOffsetX = -20
cfg.PetBuffIconOffsetY = -30

----------------------------------------------------------------------------------------------------
--[[player buff list
monitor the important buffs on yourself
create different list depend on your class
save some space compared by using a long list listing all spells
also makes the list cleaner
]]
local DeathknightBuffList = {
  -- -- unholy
  -- 81340,  -- sudden doom
  -- -- frost
  -- 51124,  -- killing machine
  -- 59052,  -- rime
  -- 51271,  -- pillar of frost
  -- 207127, -- hungering rune weapon
  -- 207256, -- obliteration
  -- -- blood

  -- --all
  -- 48707,  -- anti magic shell
  -- 101568, -- dark succor
}
local DemonHunterBuffList = {

}
local DruidBuffList = {
  -- restoration
  155777, -- rejuvenation germination / 回春术（萌芽）
  33763,  -- lifebloom / 生命绽放
  114108, -- soul of the forest / 丛林之魂
  22812,  -- barkskin / 树皮术
  102342, -- ironbark / 铁木树皮
  33891,  -- incarnation tree of life / 化身：生命之树
  -- balance
  157228, -- owlkin frenzy / 枭兽狂怒
  164545, -- solar enpowerment / 日光增效
  164547, -- lunar enpowerment / 月光增效
  102560, -- incarnation chosen of elune / 化身：艾露恩之眷
  -- feral
  69369,  -- predatory swiftness / 掠食者的迅捷
  145152, -- bloodtalons / 血腥爪击
  52610,  -- savage roar / 野蛮咆哮
  5217,   -- tigers fury / 猛虎之怒
  102543, -- incarnation king of the jungle / 化身：丛林之王
  -- 135700, -- clearcasting
  -- guardian
  102558, -- incarnation son of ursoc / 化身：乌索克的守护者
  -- all
  774,    -- rejuvenation / 回春术
  16870,  -- clearcast / 节能施法
}
local HunterBuffList = {
  --53257,  --cobra strikes
  --5384, -- feign death
  -- 5118,   -- aspect of the cheetah
  -- 13159,  -- aspect of the pack
  -- 19623,  -- frenzy
  -- 82692,  -- focus fire
  -- 168980, -- lock and load
  -- 34720,  -- thrill of the hunt
  -- 177668  -- steady focus
}
local MageBuffList = {
  -- frost
  11426,  -- ice barrier / 寒冰护体
  44544,  -- fingers of frost / 寒冰指
  190446, -- brain freeze / 冰冷智慧
  12472,  -- icy veins / 冰冷血脉
  -- fire
  235313, -- blazing barrier / 烈焰护体
  48107,  -- heating up / 热力迸发
  48108,  -- pyroblast / 炽热连击！
  190319, -- combustion / 燃烧
  -- arcane
  235450, -- prismatic barrier / 棱光屏障
  79683,  -- arcane missiles / 奥术飞弹！
  212799, -- displacement beacon / 闪回信标
  205025, -- presence of mind / 气定神闲
  12042,  -- arcane power / 奥术强化
  -- all
  116267, -- incanter's flow / 咒术洪流
}
local MonkBuffList = {
  -- 125359, -- tiger power
  -- 125195  -- tigereye brew
}
local PaladinBuffList = {
  -- holy
  -- 54149,  -- infusion of light
  -- 216411, -- divine purpose
  -- retribution
  238996,
  223819, -- divine purpose
  209785,  -- the fires of justice
}
local PriestBuffList = {
  -- -- discipline
  -- 121557, -- angelic feather
  -- 33206,  -- pain suppression
  -- 47536,  -- rapture
  -- 45242,  -- focused will
  -- -- shadow
  -- 194249, -- voidform
  -- -- holy
  -- -- all
  -- 17,     -- power word: shield
}
local RogueBuffList = {
  -- -- assassination
  -- 32645,  -- envenom
  -- outlaw
  195627, -- opportunity
  5171, -- slice
  -- -- subtlety
  -- 185422,  -- shadow dance
  -- 212283, -- symbols of death
  -- 227151, --
  -- -- all
  -- 31224,  -- cloak
  -- 1966   -- feint
}
local ShamanBuffList = {
  -- restoration
  73685,  -- unleash life / 生命释放
  53390,  -- tidal waves / 潮汐奔涌
  108281, -- ancestral guidance / 先祖指引
  207288, -- queen ascendant / 女王崛起
  79206,  -- spiritwalkers grace / 灵魂行者的恩赐
  -- elemental
  191877, -- power of the maelstrom / 漩涡之力
  -- enhancement
  201846, -- stormbringer / 风暴使者
  215785, -- hot hand / 灼热之手
  -- all
  77762,  -- lava surge / 熔岩奔腾
  108271, -- astral shift / 星界转移
  114050, -- ascendance / 升腾(元素)
  -- 114051, -- ascendance / 升腾(增强)
  -- 114052, -- ascendance / 升腾(恢复)
}
local WarlockBuffList = {
  -- all
  -- 196098, -- soul harvest
  -- 104773  -- unending resolve
}
local WarriorBuffList = {
  -- arms
  248625, -- shattered defenses / 粉碎防御
  165638, -- vicious strike / 恶毒打击
  60503,  -- overpower! / 压制！
  -- fury
  184362, -- enrage / 激怒
  206316, -- massacre / 屠杀
  201009, -- juggernaut / 主宰
  215570, -- wrecking ball / 摧枯拉朽
  85739,  -- meat cleaver / 血肉顺劈
  -- protection
  203581, -- dragon scales / 龙鳞
  5302,   -- revenge / 复仇！
  -- all
  1719,   -- battle cry / 战吼
  225947, -- stone heart / 石之心
  18499,  -- berserker rage / 狂暴之怒
  32216,  -- victorious / 胜利
}

local pro_tbl = {
  DEATHKNIGHT = DeathknightBuffList,
  DRUID = DruidBuffList,
  HUNTER = HunterBuffList,
  MAGE = MageBuffList,
  MONK = MonkBuffList,
  PALADIN = PaladinBuffList,
  PRIEST = PriestBuffList,
  ROGUE = RogueBuffList,
  SHAMAN = ShamanBuffList,
  WARLOCK = WarlockBuffList,
  WARRIOR = WarriorBuffList,
  DEMONHUNTER = DemonHunterBuffList
}

----------------------------------------------------------------------------------------------------
--[[player debuff list
monitor the important debuffs on yourself]]
cfg.PlayerDebuffList = {
  41425,  -- hypotermia
  113942, -- demonic gateway
  131894, -- a murder of crows
}
----------------------------------------------------------------------------------------------------
--[[target buff list
monitor the important buffs on your target
same as focus buff list]]
cfg.TargetBuffList = {
  ----[racial]
  65116,
  ----[rogue]
  -- 5277,   -- evasion
  -- 31224,  -- cloak
  ----[mage]
  12472,  -- icy veins / 冰冷血脉
  190319, -- combustion / 燃烧
  12042,  -- arcane power / 奥术强化
  ----[druid]
  --[burst]
  106951, -- berserk / 狂暴
  194223, -- celestial alignment / 超凡之盟
  102543, -- incarnation king of the jungle / 化身：丛林之王
  102560, -- incarnation chosen of elune / 化身：艾露恩之眷
  --[defend]
  22812,  -- barkskin / 树皮术
  61336,  -- survival instincts / 生存本能
  102342, -- ironbark / 铁木树皮  
  208253, -- essence of ghanir / 加尼尔的精华
  ----[shaman]
  --[totems]
  201633, -- earthen shield / 大地之盾
  --[burst]
  205495, -- stormkeeper / 风暴守护者
  204945, -- doom winds / 毁灭之风
  114050, -- ascendance / 升腾(元素)
  -- 114051, -- ascendance / 升腾(增强)
  -- 114052, -- ascendance / 升腾(恢复)
  --[defend]
  79206,  -- spiritwalkers grace / 灵魂行者的恩赐
  108271, -- astral shift / 星界转移
  ----[dk]
  -- 48792,  -- icebound
  -- 108201, -- desecrated ground
  -- 48707,  -- anti-magic shell
  ----[pala]
  -- 642,    -- bubble
  -- 1022,   -- protection
  -- 6940,   -- sacrifice
  -- 31884,  -- avenging wrath
  -- 105809, -- holy avenger
  ----[hunter]
  -- 5384,   -- feign death
  -- 19263,  -- deterrence
  -- 53271,  -- master's call
  -- 53480,  -- roar of sacrifice
  ----[monk]
  -- 115203, -- fortifying brew
  -- 122470, -- touch of karma
  ----[priest]
  -- 17,     -- test
  -- 33206,  -- pain suppression
  -- 62618,  -- power word:barrier
  -- 47788,  -- guardian spirit
  ----[warrior]
  --[burst]
  1719,   -- battle cry / 战吼
  --[defend]
  118038, -- die by the sword / 剑在人在
  184364, -- enraged regeneration / 狂怒回复
  871,    -- shield wall / 盾墙
  227847, -- bladestorm-arms / 剑刃风暴(武器)
  -- 46924,  -- bladestorm-fury / 剑刃风暴(狂暴)
  18499,  -- berserker rage / 狂暴之怒
  ----[warlock]
  -- 108359, -- dark regeneration
  -- 108416  -- Sacrificial pact
}
----------------------------------------------------------------------------------------------------
--[[pet buff list
so far only monitor the ment pet buff on hunter's pet]]
cfg.PetBuffList = {
  136     -- mend pet / 治疗宠物
}
----------------------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		_, cfg.class = UnitClass("player")
    cfg.PlayerBuffList = pro_tbl[cfg.class]
    cfg.list_tbl = cfg.list_tbl or {
		  PlayerBuff = cfg.PlayerBuffList,
    	PlayerDebuff = cfg.PlayerDebuffList,
    	TargetBuff = cfg.TargetBuffList,
    	FocusBuff = cfg.TargetBuffList,
    	PetBuff = cfg.PetBuffList
		}
  end
end)
