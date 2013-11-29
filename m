From: Shariyar <syed.shariyar@gmail.com>
Subject: Extracting System Call IDs By Using TMF
Date: Thu, 28 Nov 2013 19:29:30 -0500
Message-ID: <CAKQh6pji+x7NV4nURCeyozMZkbJJXfAbHvLNJJ95y21CoXT-=Q__43227.045730646$1385685035$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0089386398=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1VmBxg-0000vh-S1
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 19:29:43 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so12787769pdj.11
	for <lttng-dev@lists.lttng.org>; Thu, 28 Nov 2013 16:29:31 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0089386398==
Content-Type: multipart/alternative; boundary=047d7b2e0a117688ea04ec45ec3c

--047d7b2e0a117688ea04ec45ec3c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I need information on how to extract system call ids from a kernel level
trace by using TMF.
For example, a sample code to iterate through a kernel trace in CTF format
is given below.

In this code, I am able to extract the system call name and its return
value. However, from the *event.getContent()* function, I could not get the
system call id for the corresponding system call name.

Kindly let me know, how to extract the system call id? By system call id I
mean the actual system call id assigned by Linux to a system call as shown
on this site: http://syscalls.kernelgrok.com/

///////////////////////////////////////////////Code
//////////////////////////////////////
public void readTrace(){

        CtfIterator  traceIterator=trace.createIterator();

        while (traceIterator.advance()){

            CtfTmfEvent event = traceIterator.getCurrentEvent();
            ITmfEventField content = event.getContent();
            String eventName=event.getEventName();

            ITmfEventField sys_exit=content.getField("ret");

            if (sys_exit != null)
                System.out.println("Ret: "+sys_exit.getValue());

            if (eventName.startsWith(LttngStrings.SYSCALL_PREFIX)
                ||
eventName.startsWith(LttngStrings.COMPAT_SYSCALL_PREFIX)) {

                        System.out.println(eventName);
             }
        }

    }
///////////////////////////////////////////////Code
//////////////////////////////////////

Regards,
Shariyar

--047d7b2e0a117688ea04ec45ec3c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I need information on how =
to extract system call ids from a kernel level trace by using TMF.<br></div=
><div>For example, a sample code to iterate through a kernel trace in CTF f=
ormat is given below. <br>
<br>In this code, I am able to extract the system call name and its return =
value. However, from the <b>event.getContent()</b> function, I could not ge=
t the system call id for the corresponding system call name.<br><br></div>
<div>Kindly let me know, how to extract the system call id? By system call =
id I mean the actual system call id assigned by Linux to a system call as s=
hown on this site: <a href=3D"http://syscalls.kernelgrok.com/">http://sysca=
lls.kernelgrok.com/</a><br>
</div><div><br><font style=3D"color:rgb(0,0,255)">/////////////////////////=
//////////////////////Code //////////////////////////////////////</font><br=
 style=3D"color:rgb(255,153,0)"><font style=3D"color:rgb(0,0,255)">public v=
oid readTrace(){<br>
=A0=A0=A0 =A0=A0=A0 <br>=A0=A0=A0 =A0=A0=A0 CtfIterator=A0 traceIterator=3D=
trace.createIterator();<br>=A0=A0=A0 =A0=A0=A0 =A0<br>=A0=A0=A0 =A0=A0=A0 w=
hile (traceIterator.advance()){<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 <br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 CtfTmfEvent=
 event =3D traceIterator.getCurrentEvent();<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 ITmfEventField content =3D event.getContent();<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 String eventName=3Devent.getEventName();<br>=A0=A0=A0 =A0=A0=A0 <=
br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ITmfEventField sys_exit=3Dcontent.getField=
(&quot;ret&quot;);<br>

=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 <br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (sys_exi=
t !=3D null)<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 System.out.println(=
&quot;Ret: &quot;+sys_exit.getValue()); <br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (eventName.startsWith(LttngStrings.=
SYSCALL_PREFIX)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || eventNa=
me.startsWith(LttngStrings.COMPAT_SYSCALL_PREFIX)) {<br>

=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 <br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 System.out.println(eventN=
ame); <br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0}<br>=A0=A0=A0 =A0=A0=A0 }<br>=
=A0=A0 <br>=A0=A0=A0 }<br></font></div><font style=3D"color:rgb(0,0,255)">/=
//////////////////////////////////////////////Code ////////////////////////=
//////////////<br>
<br style=3D"color:rgb(0,0,0)"></font></div><font style=3D"color:rgb(0,0,25=
5)"><span style=3D"color:rgb(0,0,0)">Regards,</span><br style=3D"color:rgb(=
0,0,0)"><span style=3D"color:rgb(0,0,0)">Shariyar</span><br></font></div>

--047d7b2e0a117688ea04ec45ec3c--


--===============0089386398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0089386398==--
