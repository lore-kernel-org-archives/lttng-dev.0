From: Farhan Shariff <farhan.shariff@hotmail.com>
Subject: C++ Dynamic library undefined reference to
	`tracepoint_dlopen'
Date: Fri, 13 Nov 2015 13:52:06 +0000
Message-ID: <BAY179-W19C0B0D520AB5BFD3EBAF492110__20399.9958154329$1447422803$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0434823047=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bay004-omc3s19.hotmail.com ([65.54.190.157])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <farhan.shariff@hotmail.com>) id 1ZxElw-0002ZL-Sx
 for lttng-dev@lists.lttng.org; Fri, 13 Nov 2015 08:52:13 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0434823047==
Content-Type: multipart/alternative;
	boundary="_eb9251f4-693d-4b9b-9803-68a52c5eaaa4_"

--_eb9251f4-693d-4b9b-9803-68a52c5eaaa4_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all=2C
When I try to link dynamic library I get tracepoint_dlopen' undefined ref :=
what is a workaround for this
[root@localhost TEST]# g++ -Wall -shared -fPIC -I. -o mylib.so hello-tp.cpp=
 -L/usr/local/lib/ -llttng-ust -ldl[root@localhost TEST]# g++ -Wall -shared=
 -fPIC -I. -L/usr/local/lib/ -o mainlib.so hello.cpp -ldl[root@localhost TE=
ST]# g++ -o hello mainlib.so mylib.so -llttng-ust -ldlmainlib.so: undefined=
 reference to `tracepoint_dlopen'collect2: error: ld returned 1 exit status

Best Regards
Farhan=20
 		 	   		  =

--_eb9251f4-693d-4b9b-9803-68a52c5eaaa4_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><div>Dear all=2C</div><div><br><=
/div><div>When I try to link dynamic library I get&nbsp=3B<b style=3D"font-=
size: 12pt=3B">tracepoint_dlopen' undefined ref :</b></div><div>what is a w=
orkaround for this</div><div><br></div><div><div>[root@localhost TEST]# g++=
 -Wall -shared -fPIC -I. -o mylib.so hello-tp.cpp -L/usr/local/lib/ -llttng=
-ust -ldl</div><div>[root@localhost TEST]# g++ -Wall -shared -fPIC -I. -L/u=
sr/local/lib/ -o mainlib.so hello.cpp -ldl</div><div>[root@localhost TEST]#=
 g++ -o hello mainlib.so mylib.so -llttng-ust -ldl</div><div><b>mainlib.so:=
 undefined reference to `tracepoint_dlopen'</b></div><div><b>collect2: erro=
r: ld returned 1 exit status</b></div></div><div><br></div><br>Best Regards=
<br>Farhan&nbsp=3B<div><br></div> 		 	   		  </div></body>
</html>=

--_eb9251f4-693d-4b9b-9803-68a52c5eaaa4_--


--===============0434823047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0434823047==--
