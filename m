From: Jeffrey Chen <cpthk@hotmail.com>
Subject: LTTng c++ loglevel not being set
Date: Wed, 24 Jun 2015 18:42:20 -0700
Message-ID: <BLU169-W5812986F014E6A9F9F766AABAE0__20079.3614531451$1435196609$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0499828242=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc3s20.hotmail.com ([65.55.116.95])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1Z7wBP-0007vl-0m
 for lttng-dev@lists.lttng.org; Wed, 24 Jun 2015 21:42:27 -0400
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

--===============0499828242==
Content-Type: multipart/alternative;
	boundary="_99b9ade8-c4fc-42b9-a06f-6c72a6eb689b_"

--_99b9ade8-c4fc-42b9-a06f-6c72a6eb689b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I noticed a macro issue with LTTng under C++. The TRACEPOINT_LOGLEVEL would=
 be ignored.

Here are my steps to repro the issue. My .tp file has the TRACEPOINT_LOGLEV=
EL macro set.
1. I generated the hello-tp.c file from the hello-tp.tp file using the lttn=
g-gen-tp tool.
2. I renamed the generated .c file into .cpp and compiled with `g++ -c -I. =
hello-tp.cpp`
3. I wrote my c++ code called and call tracepoint macro=2C saved to hello.c=
pp=2C compiled with `g++ -c -I. hello.cpp`
4. I compile to an executable with `g++ -o hello hello.o hello-tp.o -llttng=
-ust -ldl`
5. I run the executable=2C and noticed the loglevel I set in the .tp file i=
s not working. All the traces are still being written as default loglevel T=
RACE_DEBUG_LINE.

I tried confirming it by using `lttng list --userspace` command and I see "=
hello_world:my_first_tracepoint (loglevel: TRACE_DEBUG_LINE (13)) (type: tr=
acepoint)"
You could see the loglevel was not set.

I tried the same steps without renaming to cpp files and build with `gcc` c=
ommand and it works fine. I also tried without renaming to cpp files but co=
mpiled with `g++` command=2C but it also does not work. It seems to have so=
mething to do with c++ name mangling. Anyone noticed this issue? Thanks.
 		 	   		  =

--_99b9ade8-c4fc-42b9-a06f-6c72a6eb689b_
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
<body class=3D'hmmessage'><div dir=3D'ltr'>I noticed a macro issue with LTT=
ng under C++. The TRACEPOINT_LOGLEVEL would be ignored.<br><br>Here are my =
steps to repro the issue. My .tp file has the TRACEPOINT_LOGLEVEL macro set=
.<br>1. I generated the hello-tp.c file from the hello-tp.tp file using the=
 lttng-gen-tp tool.<br>2. I renamed the generated .c file into .cpp and com=
piled with `g++ -c -I. hello-tp.cpp`<br>3. I wrote my c++ code called and c=
all tracepoint macro=2C saved to hello.cpp=2C compiled with `g++ -c -I. hel=
lo.cpp`<br>4. I compile to an executable with `g++ -o hello hello.o hello-t=
p.o -llttng-ust -ldl`<br>5. I run the executable=2C and noticed the logleve=
l I set in the .tp file is not working. All the traces are still being writ=
ten as default loglevel TRACE_DEBUG_LINE.<br><br>I tried confirming it by u=
sing `lttng list --userspace` command and I see "hello_world:my_first_trace=
point (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)"<br>You could se=
e the loglevel was not set.<br><br>I tried the same steps without renaming =
to cpp files and build with `gcc` command and it works fine. I also tried w=
ithout renaming to cpp files but compiled with `g++` command=2C but it also=
 does not work. It seems to have something to do with c++ name mangling. An=
yone noticed this issue? Thanks.<br> 		 	   		  </div></body>
</html>=

--_99b9ade8-c4fc-42b9-a06f-6c72a6eb689b_--


--===============0499828242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0499828242==--
