# Rama web demo

docker compose สำหรับทดสอบระบบเบื้องต้น ซึ่งประกอบด้วย module ต่างๆ ดังนี้ 

| Name          | Description                              |
|---------------|------------------------------------------|
| `keycloak`    | ตัวจัดการ authentication & authorization |
| `keycloak-db` | database สำหรับ keycloak                 |
| `apisix`      | api gateway                              |
| `etcd`        | key-value store สำหรับ api gateway       |
| `backend`     | backend ที่เขียนด้วย php                 |
| `frontend`    | frontend ที่เขียนด้วย nextjs             |

## วิธีติดตั้ง
0. clone project and cd to the folder
    ```bash
    $ git clone https://github.com/V-Redicalz/rama-demo.git && cd rama-demo
    ```
1. deploy app ด้วยคำสั่ง
    ```bash
    $ docker compose up -d
    ```

2. check status ของ container
    ```bash
    $ docker compose ps
    ```
    ![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047713669577973832/image.png)


3. ขั้นต่อไปทำการสร้าง Realm ที่ Keycloak โดยไปที่ http://<IP_APPRESS>:8080 เลือก Administration Console
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047715085646299187/image.png)


4. ทำการ login ด้วย admin:admin


5. click dropdown เลือก create realm
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047720158468263946/image.png)


6. กด browse เลือกไฟล์ keycloak/keycloak-rama-demo.json จากนั้นกด create
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047721587404722326/image.png)


7. ไปที่ client -> web-app ทำการแก้ไข highlight สีเหลืองให้เป็น IP_ADDRESS ของเครื่องที่รัน docker compose up -d แล้วปุ่ม Save
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047725173106802749/image.png)


7. จากนั้นกดที่ tab credentials กด Regenerate แล้วกด Copy Client secret key
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047726338368339978/image.png)


8. นำ Client secret key ที่ได้ไปใส่ใน frontend/.env ส่วนของ KEYCLOAK_SECRET
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047728675631681576/image.png)


9. เปลี่ยน IP_ADDRESS เป็นของเครื่องที่รัน docker compose up -d ตาม highlight สีเหลือง
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047728598422933584/image.png)


10. ต่อไปคือการสร้าง upstream กับ route ที่ api gateway. แต่ก่อนที่จะสร้างนั้นให้ทำการเช็ค backend ก่อนว่าทำงานปกติ (status 200) หรือไม่ โดยใช้คำสั่ง
    ```bash
    $ curl -Is http://IP_ADDRESS:10000/app-01/data.php
    ```
      ![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047732077082198016/image.png)


11. รัน script ./create_api.sh 
    ```bash
    $ sh ./create_api.sh
    ```
![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047733780728778772/image.png)


12. ทดสอบ call api ผ่าน api gateway.
    ```bash
    $ curl -ss http://IP_ADDRESS:9080/app-01/data.php
    ```
    ![run $ docker compose ps](https://cdn.discordapp.com/attachments/772734969003900950/1047735138676637769/image.png)


13. ทำการ restart app frontend ด้วยทำสั่ง 
    ```bash
    $ docker compose restart frontend
    ```

14. เข้าเว็บ http://IP_ADDRESS เพื่อทำการทดสอบต่างๆ เช่น register, login, ดึงข้อมูลผ่าน api gateway มาแสดงผลที่ frontend
