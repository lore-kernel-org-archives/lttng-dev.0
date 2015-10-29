From: Martin Andersson Z <martin.z.andersson@ericsson.com>
Subject: lttng-relayd on Solaris Permission deniedin
	utils_mkdir_recursive()
Date: Thu, 29 Oct 2015 09:17:41 +0300
Message-ID: <5631BA05.1080100__35614.9356383414$1446099572$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685364259=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg22.ericsson.net ([193.180.251.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martin.z.andersson@ericsson.com>) id 1ZrgXY-000269-Pi
 for lttng-dev@lists.lttng.org; Thu, 29 Oct 2015 02:18:29 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0685364259==
Content-Type: multipart/alternative;
	boundary="------------030407090809070706060301"

--------------030407090809070706060301
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hej

Using the lttng-relayd on a Solaris10 (SunOS 5.10 Generic_150401-20=20
i86pc i386 i86pc)

Give the following result.

=2E/lttng-relayd -C tcp://0.0.0.0:5342 -D tcp://0.0.0.0:5343 -L=20
net://localhost:5344-o */home/XXXX/YYYY/lttng-traces* -b
PERROR- 12:34:37.861906 [6546/6546]: mkdir recursive: Permission denied=20
(in _utils_mkdir_recursive_unsafe() at utils.c:621)
PERROR- 12:34:37.864154 [6546/6546]: mkdir /home/XXXX/YYYY/lttng-traces, =

uid -1, gid -1: Permission denied (in utils_mkdir_recursive() at=20
utils.c:663)

If I do a truss and start the above mentioned command, the "mkdir"=20
recursion stop because of permission (not because it exist), this will=20
then break out of _utils_mkdir_recursive

*/egrep mkdir truss.log /*
mkdir("/home", 0770) Err#17 EEXIST
mkdir("/home/XXXX", 0770) Err#13 *EACCES*

However it shall be noted, I'm doing this as the user being the owner of =

the home directory.

*/ls -ld /home /home/XXXX/*
drwxr-xr-x 409 root root       16384 Oct 20 11:47 /home
drwxr-x--- 199 XXXX nms        49152 Oct 27 06:15 /home/XXXX

If I try the following little exercise "directly" in Solaris, it works=20
with no problem.
/mkdir -p /home/XXXX/YYYY/

Don't know if it has something to do with file-system, so I give you=20
some info in that area.
*/*                  (//dev/md/dsk/d70 / ):         8192 block=20
size          1024 frag size
41310292 total blocks   24403016 free blocks 23989914 available       =20
2486848 total files
  2270183 free files     22282310 filesys id
*ufs* fstype       0x00000004 flag             255 filename length

*/home * (/nas2:/vx/oss1a-home/):        8192 block size 512 frag size
635023360 total blocks  143270864 free blocks 142440496 available        =

3324224 total files
  2238606 free files     82837519 filesys id
*nfs* fstype         00000000 flag        4294967295 filename length

For the moment I can get everything going, by changing the path to /tmp=20
instead.
But I report this since I'm not sure that we shall bail out on=20
_utils_mkdir_recursive() because of permission (maybe that's the correct =

choice to make, simply don't know).

had=C3=A9gott
/Martin


--------------030407090809070706060301
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hej<br>
    <br>
    Using the lttng-relayd on a Solaris10 (SunOS 5.10 Generic_150401-20
    i86pc i386 i86pc)<br>
    <br>
    Give the following result.<br>
    <br>
    <tt>./lttng-relayd -C tcp://0.0.0.0:5342 -D tcp://0.0.0.0:5343 -L </t=
t><tt><a
        class=3D"moz-txt-link-freetext" href=3D"net://localhost:5344"><a =
class=3D"moz-txt-link-freetext" href=3D"net://localhost:5344">net://local=
host:5344</a></a></tt><tt>
      -o <b>/home/XXXX/YYYY/lttng-traces</b> -b</tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"color:red">PERROR</span></tt><tt> -=

      12:34:37.861906 [6546/6546]: mkdir recursive: Permission denied
      (in _utils_mkdir_recursive_unsafe() at utils.c:621)</tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"color:red">PERROR</span></tt><tt> -=

      12:34:37.864154 [6546/6546]: mkdir /home/XXXX/YYYY/lttng-traces,
      uid -1, gid -1: Permission denied (in utils_mkdir_recursive() at
      utils.c:663)</tt><tt><br>
    </tt><tt><br>
    </tt>If I do a truss and start the above mentioned command, the
    "mkdir" recursion stop because of permission (not because it exist),
    this will then break out of _utils_mkdir_recursive<br>
    <br>
    <tt><b><i><span style=3D"font-size:10.0pt">egrep mkdir truss.log </sp=
an></i></b></tt><br>
    <tt><span style=3D"font-size:10.0pt">mkdir("/home", 0770) =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=C2=A0
        Err#17 EEXIST</span></tt><br>
    <tt><span style=3D"font-size:10.0pt">mkdir("/home/XXXX", 0770)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
        Err#13
        <font color=3D"#ff0000"> <b>EACCES</b></font></span></tt><br>
    <br>
    However it shall be noted, I'm doing this as the user being the
    owner of the home directory.<br>
    <br>
    <tt><b><i><span style=3D"font-size:10.0pt">ls -ld /home /home/XXXX</s=
pan></i></b></tt><br>
    <tt><span style=3D"font-size:10.0pt">drwxr-xr-x 409 root=C2=A0=C2=A0=C2=
=A0=C2=A0
        root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384 Oct 20 11:47 /home=
</span></tt><br>
    <tt><span style=3D"font-size:10.0pt">drwxr-x--- 199 XXXX =C2=A0 =C2=A0=

        nms=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 49152 Oct 27 06:15 =
/home/XXXX</span></tt><br>
    <br>
    If I try the following little exercise "directly" in Solaris, it
    works with no problem.<br>
    <i>mkdir -p /home/XXXX/YYYY</i><br>
    <br>
    Don't know if it has something to do with file-system, so I give you
    some info in that area.<br>
    <tt><span style=3D"font-size:10.0pt"><b>/</b>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (<i>/dev/md/dsk/d70=C2=A0=C2=A0</i>
        ):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8192 block siz=
e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1024 frag size=C2=
=A0 </span></tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt">41310292 total
        blocks=C2=A0=C2=A0 24403016 free blocks 23989914 available=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2486848
        total files</span></tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt">=C2=A02270183 fre=
e
        files=C2=A0=C2=A0=C2=A0=C2=A0 22282310 filesys id=C2=A0 </span></=
tt><tt> </tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt">=C2=A0=C2=A0=C2=A0=
=C2=A0 <b>ufs</b>
        fstype=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000004 flag=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 255 filen=
ame length</span></tt><tt><br>
    </tt><tt> </tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt"><b>/home=C2=A0</b=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=


        (<i>nas2:/vx/oss1a-home</i>):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8192 block size=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
        512 frag size=C2=A0 </span></tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt">635023360 total
        blocks=C2=A0 143270864 free blocks 142440496 available=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3324224
        total files</span></tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt">=C2=A02238606 fre=
e
        files=C2=A0=C2=A0=C2=A0=C2=A0 82837519 filesys id=C2=A0 </span></=
tt><tt> </tt><tt><br>
    </tt><tt> </tt><tt><span style=3D"font-size:10.0pt">=C2=A0=C2=A0=C2=A0=
=C2=A0 <b>nfs</b>
        fstype=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000 f=
lag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4294967295 filename length<=
/span></tt><tt><br>
    </tt><tt> </tt><br>
    For the moment I can get everything going, by changing the path to
    /tmp instead.<br>
    But I report this since I'm not sure that we shall bail out on
    _utils_mkdir_recursive() because of permission (maybe that's the
    correct choice to make, simply don't know). <br>
    <br>
    had=C3=A9gott<br>
    /Martin<br>
    <br>
  </body>
</html>

--------------030407090809070706060301--


--===============0685364259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0685364259==--
