### kitty-cup

Functionality:
0. Only once: App asks you your name. Don't have to choose yourself on the start round screen, it knows you. It only prompts for certain hole details for "you" 
1. Knows hole-by-hole details of golf courses.
    * Version 1 will hard code a few courses into the program.
    * Subsequently add the ability to enter a course manually, and eventually have a set of courses in the cloud that can be downloaded.
    * Or, could possibly download these details from a public database
2. Start new round: Allows entry of:
    * number of players
    * names of players - App will remember players that it has seen before so you can choose from list of last N players you kept score for to avoid typing.
    * Choose course from available course list
    * tees played
    * whether or not kitty cup feature is active for this round. 
3. For each hole, allows entering the following data for each player:
    * Score
    * Fairway Flag (applies only to par 4’s & 5’s) "you" only
    * Number of putts
    * Sand shot count (for green side bunkers)
    * Up & Down status, one of Y/N/NA (note it will keep track of scrambling automatically - this is for kitty point purposes)
    * Penalty stroke count "you" only
    * Tee shot club: "you" only. Default to driver? Advanced: Choose default based on yardage? Based on history for this hole from previous rounds?
    * Tee shot flags: push, pull, hook, slice, fat, thin "you" only
    * Notes "you" only
    * App will keep track of kitty cup points for each player automatically. Will display running kitty cup points totals for the round.
    * App will keep track of season long kitty cup points (save this data to iCloud?)
    * Settings screen will allow entry of kitty cup point awards. Defaults are 1 for bogey, 2 for par, 4 for birdie, 8 for eagle.
        * Extra point for up & down. Extra 2 points for sand up & down. Minus one point for a 3 putt.
    * Note: User need not enter GIR, it can be deduced from par value of hole, score, and number of putts. Namely if score - num_putts <= par - 2

Modes:

 * When no round is active, there will be a home screen containing three buttons.
     * One button to start a round, brings up the “start round” screen
     * One button to see stats screen (for season long stats)
     * A button to enter round review mode for any previous round
 * When round is active there are 2 views:
     * Data entry view
         * allows you to enter data or edit data for any hole
         * swipe right/left to switch holes; swipe up down to change players
         * On the data entry view there will be a row for each player showing scoring summary for each player including number of kitty points for that hole.
         * Tap on a row to edit or enter data for that hole for that player.
     * Round Summary view.
         * Row for each player summarizing whole round stats. Shows Kitty points, birdie count, par count, bogey count, other count.
         * Shows Putt count & avg. Fairways hit x/y. GIR x/y. 3-putts x/y. Total score; projected score.
    * If you swipe up or down  past all the players, you come back to the Round Summary View. From the Round Summary View, swipe up or down again to go back to the players.
    * Double-tap any view while a round is active brings up "end round" dialog w/ choices to Save, Delete, or Cancel
 * Extra Feature: While round is active, change to landscape for a traditional scorecard view. Shows holes, scores, & kitty points
 * Round review mode:
     * Summary screen shows players, scores, course, date, & kitty points
     * Tap a player to view hole by hole details
     * Must allow editing round data to correct errors.
     * Scorecard view shows scrollable virtual scorecard showing all holes w/ scores & kitty points. Landscape View.



### Version 0.1
---------------
First version to have very limited functionality as follows:
 * Design goal: Keep logic and interface separate so this app can be ported to WatchOS.
 * Hard Coded course details for Naperbrook only
 * No storing anything to cloud. No CoreDB. Local file only. Email file at end of round. (JSON?). Or even simpler manually export file using iExplorer:)
 * No settings screen, use all default values)
 * Placeholder for season-long-stats button - no season long stats available
 * Placeholder for round review mode.
 * Home Screen View (Shows 3 buttons: Start new round, load round, and (greyed out) season stats view.
 * Start Round View. App won't remember history yet. Will assume "you" are  playing.
 * Round Summary view (shows all players)
 * Data entry detail view (shows one player for specific hole)

