API List
// add row on Notification Table
app.post("/notification", (req, res) => {}
//add new user
[DONE] app.post("/api/user", (req, res) => {}
//get user token ID based on uuid and latest on db
[DONE] app.get("/api/user-token/:uuid" (req, res) => {}
//get list of routes (breeze - ice) dkk
[DONE] app.get("/api/routes", (req, res) => {}
//get list stop all
[DONE] app.get("/api/stops/all", (req, res) => {}
// 1. get list of bus
[DONE] app.get("/api/buses", (req, res) => {}
// 2. get list stop based on routes (departure, return) -- selected bus_id
[DONE] app.get("/api/stops/bus/:bus_id", (req, res) => {
// 2b. get list stop based on routes (departure, return) -- selected bus_id & direction
[DONE] app.get("/api/stops/direction/:bus_id/:direction", (req, res) => {
//get all schedules
[DONE] app.get("/api/schedule/all", (req, res) => {
//3. get from schedule with parameter : stop_id
[DONE] app.get("/api/schedule/stop/:stop_id", (req, res) => {
	// update dailyschedule
[DONE] app.put("/api/schedule/update/", (req, res) => {
//4. get from schedule with parameter : trip_id
[DONE] app.get("/api/schedule/trip/:trip_id", (req, res) => {
	// 5. upload data check (naik turun)
[DONE] app.post("/api/commute/", (req, res) => {}
	// 1. Add Reminder
[DONE] app.post("/api/reminder/add", (req, res) => {
	//3. Update reminder all properties
[DONE] app.put("/api/reminder/update/", (req, res) => {
	// 2. Update is_active
[DONE] app.put("/api/reminder/update-active/", (req, res) => {
// 4. Get reminder per user
[DONE] app.get("/api/reminder/user/:user_id", (req, res) => {
//5. Get reminder per id reminder
[DONE] app.get("/api/reminder/item/:reminder_id", (req, res) => {




