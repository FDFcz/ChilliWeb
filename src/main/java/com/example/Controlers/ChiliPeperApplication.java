package com.example.Controlers;

import com.example.Structures.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


public class ChiliPeperApplication {
	private static DatabaseControler dbControler ;
	private static AuthorizationControler aControler = new AuthorizationControler();
	private static PLCControler plcControler;
	private static PhotoController photoController = new PhotoController();

	public static void run() {
			dbControler = new DatabaseControler();
			dbControler.initDB();
			plcControler = new PLCControler();
	}
	public static String getHTMLTable(String table)
	{
		String[][] myDictionary = dbControler.getAllTAble(table);
		String htmlTag = "<table><tr><th colspan="+(myDictionary[0].length)+">"+table+"</th></tr><tr>";
		if(myDictionary.length>0) {
			for(int j = 0; j < myDictionary[0].length; j++)
			{
				htmlTag += "<th>" + myDictionary[0][j] +"</th>";
			}
			htmlTag += "</tr>";

			for(int i = 1; i < myDictionary.length; i++) {
				htmlTag += "<tr>";
				for(int j = 0; j < myDictionary[0].length; j++) {
					htmlTag += "<td>" + myDictionary[i][j] + "</td>";
				}
				htmlTag += "</tr>";
			}
		}
		htmlTag +="</table>";

		return htmlTag;
	}
//region [teracota]
	public static void addTeracota(Customer user, Teracota teracota)
	{
		Teracota newTera = dbControler.addTeracota(user.getId(), teracota.getName(),teracota.getPlantID());
		if(newTera != null)
		{
			plcControler.addTeracota(newTera);
			photoController.createPhotoDir(""+newTera.getId());
		}
	}
	public static Teracota getTeracota(int teraID) {return plcControler.getActualValues(teraID);}
	public static Teracota getTeracotaFromDatabese(int teraID){ return dbControler.getTeracota(teraID);}
	public static Teracota[] getAllTeracotas() {return dbControler.getAllTeracotas();}
	public static void deleteTeracota(int teraID)
	{
		if(dbControler.deleteTeracota(teraID)) plcControler.removeTeracota(teraID);
	}
	public static Plant getPlant(int plantTypeID) {return dbControler.getPlant(plantTypeID);}
	//endregion

//region [Customer]
	public static int getUserID(String userName) {return dbControler.getUserID(userName);}
	public static Customer getUser(int id) {return dbControler.getUser(id);}
	public static Customer getUserWithTeracotas(int id) {return dbControler.getUserWithTeracotas(id);}
	public static int registryNewUser(String userName, String password,String email,String tell) {return dbControler.registryNewUser(userName, aControler.getHash(password),email,tell);}
	//endregion

	//region [Cron]
	public static void addNewCron(int teraID) {dbControler.addNewCron(teraID);}
	public static void updateCron(Cron cron,int terraId)
	{
		dbControler.updateCron(cron);
		plcControler.updateCron(terraId);
	}
	public static void deleteCron(int cronID){dbControler.deleteCron(cronID);}
	public static Cron[] getActiveCrons(int currenHour){return dbControler.getActiveCrons(currenHour);}
	public static List<Cron> getCronsForTeracota(int teraID){return dbControler.getCronsToTeracota(teraID);}
	public static Cron getActiveCronForTeracota(int teraID,int hour){return dbControler.getActiveCronfromTeracota(teraID,hour);}
	//endregion

	public static PLC getPLC(int teracotaID){return dbControler.getPLC(teracotaID);}
	public static Schedule getSchedule(int scheduleID){return dbControler.getSchedule(scheduleID);}

	public static boolean takeSnap(int teracottaID)
	{
		LocalDateTime date = LocalDateTime.now();
		String teracotaFolder = "\\"+teracottaID;
		String fileName = date.getYear()+"-"+date.getMonthValue()+"-"+date.getDayOfMonth()+".jpg";
		photoController.takeSnapshot(teracotaFolder,fileName);
		return true;
	}
	public static String takeActualSnap(int teracottaID)
	{
		String teracotaFolder = "\\"+teracottaID+"\\custom";
		String fileName = "temp.jpg";
		photoController.takeSnapshot(teracotaFolder,fileName);
		return photoController.getActualPhoto(teracottaID);
	}
	public static ArrayList<String> getPictures(String teracotaPath,int n)
	{
		return photoController.getPhotos(teracotaPath,n);
	}
}
