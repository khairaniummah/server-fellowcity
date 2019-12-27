API List
// add row on Notification Table
app.post("/notification", (req, res) => {
//add new user
app.post("/api/user", (req, res) => {
//get user token ID based on uuid and latest on db
app.get("/api/user-token/:uuid" (req, res) => {
//get list of routes (breeze - ice) dkk
app.get("/api/routes", (req, res) => {
//get list stop all
app.get("/api/stops/all", (req, res) => {
// 1. get list of bus
[] app.get("/api/buses", (req, res) => {
// 2. get list stop based on routes (departure, return) -- selected bus_id
app.get("/api/stops/bus/:bus_id", (req, res) => {
// 2b. get list stop based on routes (departure, return) -- selected bus_id & direction
app.get("/api/stops/direction/:bus_id/:direction", (req, res) => {
//get all schedules
app.get("/api/schedule/all", (req, res) => {
//3. get from schedule with parameter : stop_id
app.get("/api/schedule/stop/", (req, res) => {
	// update dailyschedule
app.put("/api/schedule/update/", (req, res) => {
//4. get from schedule with parameter : trip_id
app.get("/api/schedule/trip/", (req, res) => {
	// 5. upload data check (naik turun)
app.post("/api/commute/", (req, res) => {
	// 1. Add Reminder
app.post("/api/reminder/add", (req, res) => {
	//3. Update reminder all properties
app.put("/api/reminder/update/", (req, res) => {
	// 2. Update is_active
app.put("/api/reminder/update-active/", (req, res) => {
// 4. Get reminder per user
app.get("/api/reminder/user/", (req, res) => {
//5. Get reminder per id reminder
app.get("/api/reminder/item/", (req, res) => {




