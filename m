From: Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
Subject: Fw: Error is thrown when continously using babeltrace
Date: Tue, 24 Feb 2015 15:07:42 +0530
Message-ID: <OF9F097B57.FB48A4A3-ON65257DF6.00345950-65257DF6.0034E9DC__18780.3252520554$1424770799$gmane$org@tcs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 0034E9D965257DF6_="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from inblrg02.tcs.com ([121.242.48.116])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=490632ad1=venkata.kantimahanthi@tcs.com>)
 id 1YQBwC-0004M0-RD
 for lttng-dev@lists.lttng.org; Tue, 24 Feb 2015 04:38:08 -0500
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

--=_mixed 0034E9D965257DF6_=
Content-Type: multipart/alternative; boundary="=_alternative 0034E9D965257DF6_="


--=_alternative 0034E9D965257DF6_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I have reproduced the issue with babeltrace -v option . 



Thanks & Regards
Venkata Ranganadh Kantimahanthi

----- Forwarded by Venkata Kantimahanthi/HYD/TCS on 02/24/2015 03:02 PM 
-----

From:   Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
To:     lttng-dev@lists.lttng.org
Date:   02/18/2015 02:29 PM
Subject:        [lttng-dev] Error is thrown when  continously using 
babeltrace



Hi, 

We are using babeltrace 1.2.4 and LTTng Trace Control 2.5.3.  Continously 
giving babeltrace is throwing this error.  I am actually getting this 
while reading a snapshot session . I have given continously babeltrace and 
path to read the traces . Then I am getting this error. 

************************************************ 
[error] Unexpected end of packet. Either the trace data stream is 
corrupted or metadata description does not match data layout. 
[error] Reading event failed. 
Error printing trace. 
 
************************************************ 
As you said previously "The corrupted stream probably can't be handled by 
Babeltrace anymore at that point." 

Please see the  below code snippet how we are using the lttng calls to 
handle our requirement 
creation of session: 
           lttng create s1 --snapshot -o /pramfs/telog 
           lttng enable-channel ch1 -u --buffers-uid --subbuf-size 4096 
--num-subbuf 16 
           # Enable default events 
           lttng enable-event -u -c ch1 --loglevel TRACE_INFO '*' 

After succesful creation of the session we are able to read the traces 
using babeltrace successfully. But we have written a wrappers for using 
lttng API calls in such a way to meet our requirement which is reading 
only traces inside the buffer at that instant by writing into a file by 
removing previously created snapshots. 

lttng_sessions[0].path contains /pramfs/telog 
myrm is a function pointer which cleans the directory and returns 770 
permissions to that particular snapshot path. 

        if (ted_ss_reboot == SS_RB_CONF) { 
                /* Only read snapshot from last reboot once */ 
                ted_ss_reboot = SS_RB_DONE; 
                extra = FCORRELATE; 
        } else { 
                /* Remove all previous snapshots from output folder 
                 * This way filesystem will not be flooded by snapshots 
                 * taken every time user reads the log. OBS, All dirs 
under 
                 * path will be deleted. 
                 */ 
                if (nftw(lttng_sessions[0].path, myrm, FOPEN_MAX, 
FTW_DEPTH) < 0) { 
                        ERR("Failed to clean path, %s", 
lttng_sessions[0].path); 
                        goto send_rsp; 
                } 
        } 

        /* 
         * Take a snapshot of lttng buffers  for a given session 
         */ 
        /* Create a output handle */ 
        if ((lttng_out = lttng_snapshot_output_create()) == NULL) { 
                ERR("lttng_snapshot_output_create failed"); 
                ret = -1; 
                goto send_rsp; 
        } 

        /* Take a snapshot, output path used is same as configured for the 
session */ 
        ret = lttng_snapshot_record(lttng_sessions[0].name, lttng_out, 0); 

        if (ret < 0) { 
                ERR("lttng_snapshot_record failed, ses:%s, %s", 
                    lttng_sessions[0].name, lttng_strerror(ret)); 
                ret = -1; 
                goto send_rsp; 
        } 


        lttng_snapshot_output_destroy(lttng_out); 

        /* 
         * snapshot folder created by root lttng-sessiond and all its 
         * subfolders have permissions set to 770, meaning non-privileged 
         * user cant read/write from/to that folder. A regular user should 

         * be able to read traces generated by root sessiond. 
         * Changing permissions to this file tree. 
         */ 
        nftw(lttng_sessions[0].path, mychmod, FOPEN_MAX, FTW_DEPTH);

babeltrace --clock-date  --clock-force-correlate /pramfs/telog 
which was giving the logs which we were expecting but if we keep this 
process repeatedly above mentioned error was coming. I am sharing the log 
file (there te log read is the wrapper call for above process which I 
mentioned).Please tell if any other logs were required. 




Thanks & Regards
Venkata Ranganadh Kantimahanthi
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_alternative 0034E9D965257DF6_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I have reproduced the issue with babeltrace
-v option . </font>
<br>
<br><font size=2 face="sans-serif"><br>
<br>
Thanks &amp; Regards<br>
Venkata Ranganadh Kantimahanthi<br>
</font>
<br><font size=1 color=#800080 face="sans-serif">----- Forwarded by Venkata
Kantimahanthi/HYD/TCS on 02/24/2015 03:02 PM -----</font>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Venkata Kantimahanthi
&lt;venkata.kantimahanthi@tcs.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">02/18/2015 02:29 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
Error is thrown when &nbsp;continously using &nbsp;babeltrace</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=2 face="sans-serif">Hi,</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
We are using babeltrace 1.2.4 and LTTng Trace Control 2.5.3. &nbsp;Continously
giving babeltrace is throwing this error. &nbsp;I am actually getting this
while reading a snapshot session . I have given continously babeltrace
and path to read the traces . Then I am getting this error.</font><font size=3>
<br>
</font><font size=2 color=#ff0041 face="Calibri"><br>
************************************************</font><font size=1 color=#ff0041 face="Arial">
</font><font size=2 color=#ff0041 face="Calibri"><br>
[error] Unexpected end of packet. Either the trace data stream is corrupted
or metadata description does not match data layout.</font><font size=1 color=#ff0041 face="Arial">
</font><font size=2 color=#ff0041 face="Calibri"><br>
[error] Reading event failed.</font><font size=1 color=#ff0041 face="Arial">
</font><font size=2 color=#ff0041 face="Calibri"><br>
Error printing trace.</font><font size=1 color=#ff0041 face="Arial"> <br>
 </font><font size=2 color=#ff0041 face="Calibri"><br>
************************************************</font><font size=1 color=#ff0041 face="Arial">
</font><font size=1 face="Arial"><br>
As you said previously &quot;</font><font size=2 face="Arial"><b>The corrupted
stream probably can't be handled by Babeltrace anymore at that point.</b></font><font size=1 face="Arial">&quot;
</font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
Please see the &nbsp;below code snippet how we are using the lttng calls
to handle our requirement</font><font size=3> </font><font size=2 face="sans-serif"><b><br>
creation of session:</b></font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng create s1 --snapshot -o /pramfs/telog</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng enable-channel ch1 -u --buffers-uid
--subbuf-size 4096 --num-subbuf 16</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # Enable default events</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng enable-event -u -c ch1 --loglevel
TRACE_INFO '*'</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
After succesful creation of the session we are able to read the traces
using babeltrace successfully. But we have written a wrappers for using
lttng API calls in such a way to meet our requirement which is reading
only traces inside the buffer at that instant by writing into a file by
removing previously created snapshots.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
lttng_sessions[0].path contains</font><font size=2 color=blue face="sans-serif">
/pramfs/telog</font><font size=3> </font><font size=2 face="sans-serif"><br>
myrm is a function pointer which cleans the directory and returns 770 permissions
to that particular snapshot path.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (ted_ss_reboot == SS_RB_CONF) {</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Only read snapshot
from last reboot once */</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ted_ss_reboot =
SS_RB_DONE;</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;extra = FCORRELATE;</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;} else {</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Remove all previous
snapshots from output folder</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * This way filesystem
will not be flooded by snapshots</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * taken every
time user reads the log. OBS, All dirs under</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * path will be
deleted.</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (nftw(lttng_sessions[0].path,
myrm, FOPEN_MAX, FTW_DEPTH) &lt; 0) {</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;ERR(&quot;Failed to clean path, %s&quot;, lttng_sessions[0].path);</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;goto send_rsp;</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;}</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; * Take a snapshot of lttng buffers &nbsp;for
a given session</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; */</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Create a output handle */</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;if ((lttng_out = </font><font size=2 color=blue face="sans-serif">lttng_snapshot_output_create</font><font size=2 face="sans-serif">())
== NULL) {</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ERR(&quot;lttng_snapshot_output_create
failed&quot;);</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret = -1;</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto send_rsp;</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;}</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* Take a snapshot, output path used is same
as configured for the session */</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;ret =</font><font size=2 color=blue face="sans-serif">
lttng_snapshot_record</font><font size=2 face="sans-serif">(lttng_sessions[0].name,
lttng_out, 0);</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0) {</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ERR(&quot;lttng_snapshot_record
failed, ses:%s, %s&quot;,</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lttng_sessions[0].name,
lttng_strerror(ret));</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret = -1;</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto send_rsp;</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;}</font><font size=3> <br>
<br>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;lttng_snapshot_output_destroy(lttng_out);</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; * snapshot folder created by root lttng-sessiond
and all its</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; * subfolders have permissions set to 770,
meaning non-privileged</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; * user cant read/write from/to that folder.
A regular user should</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; * be able to read traces generated by root
sessiond.</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; * Changing permissions to this file tree.</font><font size=3>
</font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; */</font><font size=3> </font><font size=2 face="sans-serif"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;nftw(lttng_sessions[0].path, mychmod, FOPEN_MAX,
FTW_DEPTH);</font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
babeltrace --clock-date &nbsp;--clock-force-correlate /pramfs/telog</font><font size=3>
</font><font size=2 face="sans-serif"><br>
which was giving the logs which we were expecting but if we keep this process
repeatedly above mentioned error was coming. I am sharing the log file
(there te log read is the wrapper call for above process which I mentioned).Please
tell if any other logs were required.</font><font size=3> <br>
<br>
<br>
</font><font size=2 face="sans-serif"><br>
<br>
Thanks &amp; Regards<br>
Venkata Ranganadh Kantimahanthi</font>
<p><font size=3>=====-----=====-----=====<br>
Notice: The information contained in this e-mail<br>
message and/or attachments to it may contain <br>
confidential or privileged information. If you are <br>
not the intended recipient, any dissemination, use, <br>
review, distribution, printing or copying of the <br>
information contained in this e-mail message <br>
and/or attachments to it are strictly prohibited. If <br>
you have received this communication in error, <br>
please notify us by reply e-mail or telephone and <br>
immediately and permanently delete the message <br>
and any attachments. Thank you</font><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
--=_alternative 0034E9D965257DF6_=--

--=_mixed 0034E9D965257DF6_=
Content-Type: text/plain; name="lttng_logs.txt.txt"
Content-Disposition: attachment; filename="lttng_logs.txt.txt"
Content-Transfer-Encoding: quoted-printable

# te log read |grep ERROR
[warning] Forcibly correlating trace clock sources (--clock-force-correlate=
).
[warning] Forcibly correlating trace clock sources (--clock-force-correlate=
).
[warning] Forcibly correlating trace clock sources (--clock-force-correlate=
).
[warning] Forcibly correlating trace clock sources (--clock-force-correlate=
).
[warning] Forcibly correlating trace clock sources (--clock-force-correlate=
).
[warning] Forcibly correlating trace clock sources (--clock-force-correlate=
).
[
[2015-02-18 08:08:44.687776921] (+0.130724586) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 2 }, { process =3D "Osa=5FlsiServer=5Fproc", f=
ileAndLine =3D "logserver.c:2872", msg =3D "The program is not reliable!" }
[2015-02-18 08:08:44.687777001] (+0.000000080) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 5 }, { process =3D "Osa=5FoeiServer=5Fproc", f=
ileAndLine =3D "objevidserver.c:380", msg =3D "OEI Server : CelloCli=5FgetR=
puReq ERROR" }
[2015-02-18 08:08:44.687788948] (+0.000011947) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 4 }, { process =3D "Osa=5FavliServer=5Fproc", =
fileAndLine =3D "avli=5Fserver.c:1545", msg =3D "The program is not reliabl=
e" }
[2015-02-18 08:08:44.687885934] (+0.000096986) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 5 }, { process =3D "Osa=5FoeiServer=5Fproc", f=
ileAndLine =3D "objevidserver.c:381", msg =3D "OEI Server : Error code is 1=
" }
[2015-02-18 08:08:44.687979934] (+0.000066000) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 4 }, { process =3D "Osa=5FhiliServer=5Fproc", =
fileAndLine =3D "hili=5Fserver.c:1634", msg =3D "The program is not reliabl=
e" }
# te log read |grep ERROR
[2015-02-18 08:08:44.458478388] (+0.008982213) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 1 }, { process =3D "Osa=5FupgradeControl=5Fpro=
c", fileAndLine =3D "upgrade=5Fcontrol=5Fserver.c:1965", msg =3D "The progr=
am is not reliable!" }
[error] Unexpected end of packet. Either the trace data stream is corrupted=
 or metadata description does not match data layout.
[error] Reading event failed.
Error printing trace.

[2015-02-18 08:08:44.687776921] (+0.130724586) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 2 }, { process =3D "Osa=5FlsiServer=5Fproc", f=
ileAndLine =3D "logserver.c:2872", msg =3D "The program is not reliable!" }
[2015-02-18 08:08:44.687777001] (+0.000000080) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 5 }, { process =3D "Osa=5FoeiServer=5Fproc", f=
ileAndLine =3D "objevidserver.c:380", msg =3D "OEI Server : CelloCli=5FgetR=
puReq ERROR" }
[2015-02-18 08:08:44.687885934] (+0.000108933) oamhost com=5Fericsson=5Ftri=
thread:ERROR: { cpu=5Fid =3D 5 }, { process =3D "Osa=5FoeiServer=5Fproc", f=
ileAndLine =3D "objevidserver.c:381", msg =3D "OEI Server : Error code is 1=
" }
Error: Command error
# lttng list s1         =20
Tracing session s1: [active snapshot]
    Trace path:=20
    Live timer interval (usec): 4294967295

=3D=3D=3D Domain: UST global =3D=3D=3D

Buffer type: per UID

Channels:
-------------
- ch1: [enabled]

    Attributes:
      overwrite mode: 1
      subbufers size: 4096
      number of subbufers: 16
      switch timer interval: 0
      read timer interval: 0
      trace file count: 0
      trace file size (bytes): 0
      output: mmap()

    Events:
      * (loglevel <=3D TRACE=5FINFO (6)) (type: tracepoint) [enabled]
      com=5Fericsson=5Ftri* (loglevel <=3D TRACE=5FDEBUG (14)) (type: trace=
point) [enabled]
--=_mixed 0034E9D965257DF6_=
Content-Type: text/plain; name="babeltrace-output.txt"
Content-Disposition: attachment; filename="babeltrace-output.txt"
Content-Transfer-Encoding: quoted-printable


EVOC> babeltrace -v /pramfs/telog

150223-16:27:04 10.67.30.197 11.0b CPP=5FMOM-CPP-LSV157-gen1=5Fgen1=5FCOMPL=
ETE stopfile=3D/tmp/19493
$ babeltrace -v /pramfs/telog
[verbose] Verbose mode active.
[verbose] Converting from directory(ies):
[verbose]     /pramfs/telog
[verbose] Converting from format: ctf <default>
[verbose] Converting to target: <stdout>
[verbose] Converting to format: text <default>
[verbose] CTF visitor: parent links creation... [verbose] done.
[verbose] CTF visitor: semantic check... [verbose] done.
[verbose] CTF visitor: metadata construction...
[verbose] env.hostname =3D "oamhost"
[verbose] env.domain =3D "ust"
[verbose] env.tracer=5Fname =3D "lttng-ust"
[verbose] env.tracer=5Fmajor =3D 2
[verbose] env.tracer=5Fminor =3D 5
[verbose] done.
[15:12:32.239911627] (+?.?????????) oamhost com=5Fericsson=5Fplf=5Ffilesys:=
filesystemInfo: { timestamp=5Fbegin =3D 9915713449, timestamp=5Fend =3D 254=
693917932, content=5Fsize =3D 22728, packet=5Fsize =3D 32768, events=5Fdisc=
arded =3D 0, cpu=5Fid =3D 23 }, { id =3D ( "extended" : container =3D 31 ),=
 v =3D { extended =3D { id =3D 80, timestamp =3D 10322997289 } } }, { file =
=3D "/repo/edanlef/cpp/control/BCS=5FCRX901143=5F1/filesys=5Fbl/filesys=5Fl=
x=5Fswu/src/lvm.c", linenumber =3D 189, msg =3D "/dev/cpplvm=5Fvg/vol1: cle=
an, 1844/244320 files, 420091/976896 blocks" }
[15:12:32.793668561] (+0.553756934) oamhost com=5Fericsson=5Fplf=5Ffilesys:=
filesystemInfo: { timestamp=5Fbegin =3D 9911313476, timestamp=5Fend =3D 254=
659198037, content=5Fsize =3D 9224, packet=5Fsize =3D 32768, events=5Fdisca=
rded =3D 0, cpu=5Fid =3D 0 }, { id =3D ( "extended" : container =3D 31 ), v=
 =3D { extended =3D { id =3D 80, timestamp =3D 10876754223 } } }, { file =
=3D "/repo/edanlef/cpp/control/BCS=5FCRX901143=5F1/filesys=5Fbl/filesys=5Fl=
x=5Fswu/src/lvm.c", linenumber =3D 189, msg =3D "/dev/cpplvm=5Fvg/vol2: cle=
an, 1047/238080 files, 416670/952320 blocks" }
[15:12:33.269662267] (+0.475993706) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912644782, timestamp=5Fend =3D 254670353552, con=
tent=5Fsize =3D 16240, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 7 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extend=
ed =3D { id =3D 7, timestamp =3D 11352747929 } } }, { process =3D "mBOS=5Fw=
elcome=5Fproc", fileAndLine =3D "welcome.c:211", msg =3D "Startup of CXC173=
7213 D1A06 2015-02-23 07:55:14 UTC
" }
[15:12:33.272519334] (+0.002857067) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913412596, timestamp=5Fend =3D 254675921617, con=
tent=5Fsize =3D 2856, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 11 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extend=
ed =3D { id =3D 7, timestamp =3D 11355604996 } } }, { process =3D "Cs=5Fboa=
rdManager=5Fproc", fileAndLine =3D "board=5Fmanager.c:1891", msg =3D "Start=
 of CXC1737213=5FD1A06" }
[15:12:33.282154828] (+0.009635494) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 11365240490 } } }, { process =3D "chpi=5Fse=
rver=5Fproc", fileAndLine =3D "chpi-server.c:515", msg =3D "CHPI: Reached C=
heckpoint ALL=5FPATCHES=5FLOADED" }
[15:12:33.282337574] (+0.000182746) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 91134084 } } }, { process =3D "chpi=5Fserver=5Fproc", f=
ileAndLine =3D "chpi-server.c:515", msg =3D "CHPI: Reached Checkpoint EARLY=
=5FHW=5FTEST=5FCOMPLETE" }
[15:12:33.282349441] (+0.000011867) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 91145951 } } }, { process =3D "chpi=5Fserver=5Fproc", f=
ileAndLine =3D "chpi-server.c:515", msg =3D "CHPI: Reached Checkpoint ALL=
=5FBOOT=5FLM=5FLOADED" }
[15:12:33.282372321] (+0.000022880) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 91168831 } } }, { process =3D "chpi=5Fserver=5Fproc", f=
ileAndLine =3D "chpi-server.c:515", msg =3D "CHPI: Reached Checkpoint NAME=
=5FSERVER=5FSTARTED" }
[15:12:33.282383788] (+0.000011467) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 91180298 } } }, { process =3D "chpi=5Fserver=5Fproc", f=
ileAndLine =3D "chpi-server.c:515", msg =3D "CHPI: Reached Checkpoint HARDD=
ISK=5FSTARTED" }
[15:12:33.284014428] (+0.001630640) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 11367100090 } } }, { process =3D "bmLoaderC=
lient", fileAndLine =3D "loader=5Fclient.c:404", msg =3D "initLoaderClient"=
 }
[15:12:33.284479388] (+0.000464960) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912644782, timestamp=5Fend =3D 254670353552, con=
tent=5Fsize =3D 16240, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 7 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 93275898 } } }, { process =3D "lcim", fileAndLine =3D "=
lcim.c:523", msg =3D "Received PMD notification for /system/pmd/pmd-packet=
=5Fserver-14262-20150223-151139.tgz" }
[15:12:33.285398054] (+0.000918666) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extend=
ed =3D { id =3D 7, timestamp =3D 11368483716 } } }, { process =3D "bmLoader=
Client", fileAndLine =3D "loader=5Fclient.c:539", msg =3D "Program handler =
default values, capabilities=3D0x17 cpu conf=3D0xffffff noOfgroups=3D1 grou=
p=3D1" }
[15:12:33.974530376] (+0.689132322) oamhost com=5Fericsson=5Fplf=5Fepb2=5Fp=
acketserver:packet=5Finfo: { timestamp=5Fbegin =3D 9911313476, timestamp=5F=
end =3D 254659198037, content=5Fsize =3D 9224, packet=5Fsize =3D 32768, eve=
nts=5Fdiscarded =3D 0, cpu=5Fid =3D 0 }, { id =3D ( "extended" : container =
=3D 31 ), v =3D { extended =3D { id =3D 60, timestamp =3D 12057616038 } } }=
, { file =3D "/repo/edanlef/cpp/control/BABS=5FCRX901142=5F1/epb2=5Flx=5Fbl=
/epb2=5Fpacket-server=5Flx=5Fswu/src/packet=5Fproc.c", linenumber =3D 1281,=
 msg =3D "Linepool has 38836 buffers of 1728 bytes with 1500 bytes payload.=
" }
[15:12:34.259134456] (+0.284604080) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extend=
ed =3D { id =3D 7, timestamp =3D 12342220118 } } }, { process =3D "bmMpRole=
", fileAndLine =3D "board=5Fmgr=5Fmp.c:681", msg =3D "checkRestartCounter" }
[15:12:34.259374402] (+0.000239946) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 128646816 } } }, { process =3D "bmMpRole", fileAndLine =
=3D "board=5Fmgr=5Fmp.c:702", msg =3D "Restart count increased to 0x1 (limi=
t=3D0x1 flag=3D0xdeadbeee)
" }
[15:12:34.259379736] (+0.000005334) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 128652150 } } }, { process =3D "bmMpRole", fileAndLine =
=3D "board=5Fmgr=5Fmp.c:1104", msg =3D "loadConfiguredLLP" }
[15:12:34.262865762] (+0.003486026) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 132138176 } } }, { process =3D "bmMpRole", fileAndLine =
=3D "board=5Fmgr=5Fcv.c:421", msg =3D "Select Configuration Version <java=
=5Fsetup=5F2302>" }
[15:12:34.263315816] (+0.000450054) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 132588230 } } }, { process =3D "bmMpRole", fileAndLine =
=3D "board=5Fmgr=5Fmp.c:888", msg =3D "loadLLP" }
[15:12:34.263319736] (+0.000003920) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 132592150 } } }, { process =3D "bmMpRole", fileAndLine =
=3D "board=5Fmgr=5Fmp.c:829", msg =3D "loadResidentProgram" }
[15:12:34.263349522] (+0.000029786) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 132621936 } } }, { process =3D "bmLoaderClient", fileAn=
dLine =3D "loader=5Fclient.c:1640", msg =3D "handleLcLoadPgmReq" }
[15:12:34.263362056] (+0.000012534) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9913795316, timestamp=5Fend =3D 29932517677, cont=
ent=5Fsize =3D 32744, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 13 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 132634470 } } }, { process =3D "bmLoaderClient", fileAn=
dLine =3D "bm=5Fpgm=5Fconfig=5Fflib.c:314", msg =3D "BmPgmConfig=5FinstallC=
ontainer" }
[15:12:34.263437949] (+0.000075893) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 12346523611 } } }, { process =3D "bmPgmConf=
ig", fileAndLine =3D "bm=5Fpgm=5Fconfig.c:1779", msg =3D "handleInstallCont=
ainerReq" }
[15:12:34.269405336] (+0.005967387) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4460022 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:748", msg =3D "Instance information instanceId=3D=
0, hwDistribution=3D0, restartGroup=3D3" }
[15:12:34.269415469] (+0.000010133) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4470155 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wit=
h lmid=3DCXC1732001%3=5FSQFS396 instanceId=3D0 loadClass=3D100 hwdistributi=
on=3D0x0 maxMem=3D0x0
" }
[15:12:34.269435789] (+0.000020320) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4490475 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with =
handle=3Dloader-server-ppc64 path=3D/usr/imagestore//CXC1732001%3=5FSQFS396=
/bin/loader-server-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:34.269487016] (+0.000051227) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 12352572678 } } }, { process =3D "bmLoaderC=
lient", fileAndLine =3D "loader=5Fclient.c:1224", msg =3D "createLmid noOfP=
rograms=3D1 nrOfPgmInstances=3D1" }
[15:12:34.269493229] (+0.000006213) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4547915 } } }, { process =3D "bmLoaderClient", fileAndL=
ine =3D "loader=5Fclient.c:1082", msg =3D "spawnProgram" }
[15:12:34.269529229] (+0.000036000) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4583915 } } }, { process =3D "bmLoaderClient", fileAndL=
ine =3D "loader=5Fclient.c:1093", msg =3D "spawnProgram CXC1732001%3=5FSQFS=
396 (instance=3D0) noOfPgms=3D1" }
[15:12:34.269533949] (+0.000004720) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4588635 } } }, { process =3D "bmLoaderClient", fileAndL=
ine =3D "loader=5Fclient.c:926", msg =3D "setProgramArgs" }
[15:12:34.287749202] (+0.018215253) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 22803888 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:936", msg =3D "serviceGetRequests" }
[15:12:34.287759709] (+0.000010507) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 22814395 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:936", msg =3D "serviceGetRequests" }
[15:12:34.287765442] (+0.000005733) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 22820128 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:936", msg =3D "serviceGetRequests" }
[15:12:35.333218536] (+1.045453094) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 13416304198 } } }, { process =3D "Osa=5Floa=
derServer=5Fproc", fileAndLine =3D "llp.c:2980", msg =3D "
#################################################################" }
[15:12:35.333750403] (+0.000531867) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 129280993 } } }, { process =3D "Osa=5FloaderServer=5Fpr=
oc", fileAndLine =3D "llp=5Farmament.c:1031", msg =3D "Start CV =3D <java=
=5Fsetup=5F2302>" }
[15:12:35.334656243] (+0.000905840) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 130186833 } } }, { process =3D "Osa=5FcoreManager=5Fpro=
c", fileAndLine =3D "osa=5Fcm=5Fmain.c:2408", msg =3D "This CM was active l=
ast time, tries for NORMAL" }
[15:12:39.905945953] (+4.571289710) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 17989031615 } } }, { process =3D "bmPgmConf=
ig", fileAndLine =3D "bm=5Fpgm=5Fconfig.c:1141", msg =3D "handleGetLmidInfo=
Req" }
[15:12:39.906045313] (+0.000099360) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 17989130975 } } }, { process =3D "Cs=5Fboar=
dManager=5Fproc", fileAndLine =3D "board=5Fmanager.c:1980", msg =3D "BM=5FA=
LL=5FPATCHES=5FLOADED=5FIND" }
[15:12:39.906058727] (+0.000013414) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9911873742, timestamp=5Fend =3D 23129405379, cont=
ent=5Fsize =3D 32120, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 3 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 3968837 } } }, { process =3D "Cs=5FboardManager=5Fproc"=
, fileAndLine =3D "board=5Fmanager.c:1980", msg =3D "BM=5FALL=5FPATCHES=5FL=
OADED=5FIND" }
[15:12:39.906586700] (+0.000527973) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4496810 } } }, { process =3D "bmStartApplicationLoad", =
fileAndLine =3D "board=5Fmanager.c:1570", msg =3D "bmStartApplicationLoad" }
[15:12:41.741037447] (+1.834450747) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 19824123109 } } }, { process =3D "Osa=5Fcor=
eManager=5Fproc", fileAndLine =3D "osa=5Fcm=5Fmain.c:2340", msg =3D "Updati=
ng CM=5FCONFIG: ownState=3DNormalActive peerSupa=3D0xffffffff peerState=3DU=
ndefined activeSupa=3D0x30000" }
[15:12:41.754456567] (+0.013419120) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 107536213 } } }, { process =3D "Osa=5FcmMci=5Fproc", fi=
leAndLine =3D "osa=5Fcm=5Fmci.c:572", msg =3D "Own sequence number mismatch=
, sent=3D58, received=3D57" }
[15:12:41.754968621] (+0.000512054) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9915324089, timestamp=5Fend =3D 254690401278, con=
tent=5Fsize =3D 21504, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 21 }, { id =3D ( "extended" : container =3D 31 ), v =3D { exten=
ded =3D { id =3D 7, timestamp =3D 19838054283 } } }, { process =3D "Osa=5Fl=
oaderServer=5Fproc", fileAndLine =3D "llp.c:774", msg =3D "Loader Server ha=
s received state Active" }
[15:12:41.755355154] (+0.000386533) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 108434800 } } }, { process =3D "Osa=5FcoreManager=5Fpro=
c", fileAndLine =3D "osa=5Fcm=5Fmain.c:1946", msg =3D "Number of CMI client=
s: own=3D4, peer=3D0" }
[15:12:41.755602674] (+0.000247520) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 108682320 } } }, { process =3D "Osa=5FcmMci=5Fproc", fi=
leAndLine =3D "osa=5Fcm=5Fmci.c:730", msg =3D "Received OSA=5FLDRI=5FMCI=5F=
TYPE=5F0 (LLP notice) from supa 0x30000" }
[15:12:41.769356114] (+0.013753440) oamhost com=5Fericsson=5Fplf=5Ffilesys:=
filesystemInfo: { timestamp=5Fbegin =3D 9913985262, timestamp=5Fend =3D 231=
08324099, content=5Fsize =3D 32712, packet=5Fsize =3D 32768, events=5Fdisca=
rded =3D 0, cpu=5Fid =3D 14 }, { id =3D ( "extended" : container =3D 31 ), =
v =3D { extended =3D { id =3D 80, timestamp =3D 19852441776 } } }, { file =
=3D "/repo/edanlef/cpp/control/BCS=5FCRX901143=5F1/filesys=5Fbl/filesys=5Fl=
x=5Fswu/src/global=5Fvolumes.c", linenumber =3D 1824, msg =3D "Core mode is=
 active" }
[15:12:41.783742834] (+0.014386720) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 2604752 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.783756007] (+0.000013173) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 2617925 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=3D=
0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.783764434] (+0.000008427) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 2626352 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wit=
h lmid=3DCXC1737213=5FD1A06 instanceId=3D0 loadClass=3D10 hwdistribution=3D=
0x0 maxMem=3D0x0
" }
[15:12:41.784737554] (+0.000973120) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 3599472 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.785318061] (+0.000580507) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 4179979 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.788132994] (+0.002814933) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 6994912 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=3D=
0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.788145740] (+0.000012746) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 7007658 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wit=
h lmid=3DCXC1321314%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistributi=
on=3D0x0 maxMem=3D0x0
" }
[15:12:41.788153207] (+0.000007467) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 7015125 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with =
handle=3Doam-sock-ppc64 path=3D/usr/imagestore//CXC1321314%3=5FSQFS396/bin/=
oam-sock-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:41.788940781] (+0.000787574) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 7802699 } } }, { process =3D "bmPgmConfig", fileAndLine=
 =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.791834781] (+0.002894000) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 10696699 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.791845287] (+0.000010506) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 10707205 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1323464%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:41.791853500] (+0.000008213) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 10715418 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dobjectsupport-ppc64 path=3D/usr/imagestore//CXC1323464%3=5FSQFS39=
6/bin/objectsupport-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:41.792453767] (+0.000600267) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 11315685 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.794712700] (+0.002258933) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 13574618 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.794722727] (+0.000010027) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 13584645 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1731998%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:41.794729767] (+0.000007040) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 13591685 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dipt-epb-ppc64 path=3D/usr/imagestore//CXC1731998%3=5FSQFS396/bin/=
ipt-epb-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:41.795325874] (+0.000596107) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 14187792 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.797307500] (+0.001981626) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 16169418 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.797319927] (+0.000012427) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 16181845 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1322506%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:41.797329634] (+0.000009707) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 16191552 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Doam-ip-utilities-ppc64 path=3D/usr/imagestore//CXC1322506%3=5FSQF=
S396/bin/oam-ip-utilities-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:41.797973981] (+0.000644347) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 16835899 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.828623074] (+0.030649093) oamhost com=5Fericsson=5Fplf=5Fntp:ntpI=
nfo: { timestamp=5Fbegin =3D 9911497156, timestamp=5Fend =3D 254660579546, =
content=5Fsize =3D 29816, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0=
, cpu=5Fid =3D 1 }, { id =3D ( "extended" : container =3D 31 ), v =3D { ext=
ended =3D { id =3D 68, timestamp =3D 19911708736 } } }, { threadName =3D "n=
tpServerManager", file =3D "/repo/edanlef/cpp/control/BCS=5FCRX901143=5F1/n=
tp=5Fbl/ntp=5Flx=5Fswu/src/ntp=5Fserver=5Fmgr.c", linenumber =3D 1307, msg =
=3D "NTP client started.Msg=3D" }
[15:12:41.840147180] (+0.011524106) oamhost com=5Fericsson=5Fplf=5Fntp:ntpI=
nfo: { timestamp=5Fbegin =3D 9911690142, timestamp=5Fend =3D 254661941615, =
content=5Fsize =3D 13248, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0=
, cpu=5Fid =3D 2 }, { id =3D ( "extended" : container =3D 31 ), v =3D { ext=
ended =3D { id =3D 68, timestamp =3D 19923232842 } } }, { threadName =3D "n=
tpNotifer", file =3D "/repo/edanlef/cpp/control/BCS=5FCRX901143=5F1/ntp=5Fb=
l/ntp=5Flx=5Fswu/src/ntp=5Finotify.c", linenumber =3D 286, msg =3D "ntp log=
 file created./var/log/ntp.log" }
[15:12:41.872094327] (+0.031947147) oamhost com=5Fericsson=5Fplf=5Fntp:ntpI=
nfo: { timestamp=5Fbegin =3D 9911497156, timestamp=5Fend =3D 254660579546, =
content=5Fsize =3D 29816, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0=
, cpu=5Fid =3D 1 }, { id =3D ( "extended" : container =3D 31 ), v =3D { ext=
ended =3D { id =3D 68, timestamp =3D 19955179989 } } }, { threadName =3D "n=
tpServerManager", file =3D "/repo/edanlef/cpp/control/BCS=5FCRX901143=5F1/n=
tp=5Fbl/ntp=5Flx=5Fswu/src/ntp=5Fserver=5Fmgr.c", linenumber =3D 2330, msg =
=3D "NTP restart" }
[15:12:41.987101582] (+0.115007255) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 9912088276, timestamp=5Fend =3D 20070303804, cont=
ent=5Fsize =3D 31736, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, cp=
u=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extende=
d =3D { id =3D 7, timestamp =3D 20070187244 } } }, { process =3D "bmPgmConf=
ig", fileAndLine =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance informati=
on instanceId=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.987218142] (+0.000116560) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 71862332 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1737947=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistributio=
n=3D0x0 maxMem=3D0x0
" }
[15:12:41.987445635] (+0.000227493) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 72089825 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibss7-sccpssif.so path=3D/usr/imagestore//CXC1737947=5FSQFS396/l=
ib/libss7-sccpssif.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:41.987452648] (+0.000007013) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 72096838 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibss7-mtp3bssif.so path=3D/usr/imagestore//CXC1737947=5FSQFS396/=
lib/libss7-mtp3bssif.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:41.987458995] (+0.000006347) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 72103185 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibss7-sctpssif.so path=3D/usr/imagestore//CXC1737947=5FSQFS396/l=
ib/libss7-sctpssif.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:41.987465528] (+0.000006533) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 72109718 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibss7-usaalssif.so path=3D/usr/imagestore//CXC1737947=5FSQFS396/=
lib/libss7-usaalssif.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:41.987471928] (+0.000006400) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 72116118 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibss7-sctpadm-ifu.so path=3D/usr/imagestore//CXC1737947=5FSQFS39=
6/lib/libss7-sctpadm-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:41.988830595] (+0.001358667) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 73474785 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:41.991781315] (+0.002950720) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 76425505 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:41.991790381] (+0.000009066) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 76434571 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1320781%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:41.991797261] (+0.000006880) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 76441451 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Ddatabase-ppc64 path=3D/usr/imagestore//CXC1320781%3=5FSQFS396/bin=
/database-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:41.991810728] (+0.000013467) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 76454918 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dposgresql.tar.gz path=3D/usr/imagestore//CXC1320781%3=5FSQFS396/t=
ar/posgresql.tar.gz instanceId=3D0 type=3D5 maxMem=3D0
" }
[15:12:41.992341635] (+0.000530907) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 76985825 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.150632142] (+1.158290507) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extend=
ed =3D { id =3D 7, timestamp =3D 21233717804 } } }, { process =3D "bmPgmCon=
fig", fileAndLine =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance informat=
ion instanceId=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.150693395] (+0.000061253) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27378033 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1737948=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistributio=
n=3D0x0 maxMem=3D0x0
" }
[15:12:43.150732622] (+0.000039227) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27417260 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibcislfh-cislfi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/libcislfh-cislfi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150740222] (+0.000007600) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27424860 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibcislfh-esfti-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS3=
96/lib/libcislfh-esfti-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150746595] (+0.000006373) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27431233 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibcsxfh-csxfi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS39=
6/lib/libcsxfh-csxfi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150753129] (+0.000006534) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27437767 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibcsxfh-csxpregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQF=
S396/lib/libcsxfh-csxpregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150759395] (+0.000006266) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27444033 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibcsxfh-csxproci-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQF=
S396/lib/libcsxfh-csxproci-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150765582] (+0.000006187) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27450220 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibcsxfh-csxregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/libcsxfh-csxregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150771742] (+0.000006160) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27456380 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesad-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS396/lib/l=
ibesad-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150778062] (+0.000006320) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27462700 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmfh-esmpregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQF=
S396/lib/libesmfh-esmpregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150784329] (+0.000006267) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 20070303804, timestamp=5Fend =3D 21233877564, con=
tent=5Fsize =3D 31864, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27468967 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmfh-esmproci-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQF=
S396/lib/libesmfh-esmproci-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150791902] (+0.000007573) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27476540 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmfh-esmregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/libesmfh-esmregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150847289] (+0.000055387) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27531927 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmfh-esbpsi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS3=
96/lib/libesmfh-esbpsi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150853902] (+0.000006613) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27538540 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmre-esmrei-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS3=
96/lib/libesmre-esmrei-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150860435] (+0.000006533) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27545073 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibethfwre-ethfwci-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQ=
FS396/lib/libethfwre-ethfwci-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150873129] (+0.000012694) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27557767 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibethfwre-ethfwdi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQ=
FS396/lib/libethfwre-ethfwdi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150879982] (+0.000006853) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27564620 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dliblagfh-lagfi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS39=
6/lib/liblagfh-lagfi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150886649] (+0.000006667) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27571287 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dliblagfh-lagregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/liblagfh-lagregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150892809] (+0.000006160) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27577447 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibstpf-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS396/lib/l=
ibstpf-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150898942] (+0.000006133) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27583580 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibvlanfh-esfci-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS3=
96/lib/libvlanfh-esfci-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150905315] (+0.000006373) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27589953 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibvlanfh-vlanfi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/libvlanfh-vlanfi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150911475] (+0.000006160) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27596113 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibebpfh-ebpregi-crm-ifu.so path=3D/usr/imagestore//CXC1737948=5F=
SQFS396/lib/libebpfh-ebpregi-crm-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150932782] (+0.000021307) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27617420 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibebpfh-ebpregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/libebpfh-ebpregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150940996] (+0.000008214) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27625634 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-epfi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS396/=
lib/libepfh-epfi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150947822] (+0.000006826) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27632460 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-epproci-crm-ifu.so path=3D/usr/imagestore//CXC1737948=5FS=
QFS396/lib/libepfh-epproci-crm-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150954062] (+0.000006240) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27638700 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-epproci-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS3=
96/lib/libepfh-epproci-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150960196] (+0.000006134) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27644834 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-epregi-crm-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQ=
FS396/lib/libepfh-epregi-crm-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150966276] (+0.000006080) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27650914 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-epregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS39=
6/lib/libepfh-epregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150972809] (+0.000006533) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27657447 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-epstatusfi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQ=
FS396/lib/libepfh-epstatusfi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150979049] (+0.000006240) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27663687 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-vlanpregi-crm-ifu.so path=3D/usr/imagestore//CXC1737948=
=5FSQFS396/lib/libepfh-vlanpregi-crm-ifu.so instanceId=3D0 type=3D3 maxMem=
=3D0
" }
[15:12:43.150985129] (+0.000006080) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21233877564, timestamp=5Fend =3D 21234083351, con=
tent=5Fsize =3D 32544, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27669767 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibepfh-vlanpregi-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQF=
S396/lib/libepfh-vlanpregi-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.150997689] (+0.000012560) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27682327 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmrx-ebprei-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS3=
96/lib/libesmrx-ebprei-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.151036942] (+0.000039253) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27721580 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmrx-l2refci-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS=
396/lib/libesmrx-l2refci-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.151043876] (+0.000006934) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27728514 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibesmrx-pmai-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQFS396=
/lib/libesmrx-pmai-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.151050142] (+0.000006266) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 27734780 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibexscmn-snmpcoli-ifu.so path=3D/usr/imagestore//CXC1737948=5FSQ=
FS396/lib/libexscmn-snmpcoli-ifu.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.152344222] (+0.001294080) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 29028860 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.155554995] (+0.003210773) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32239633 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.155564755] (+0.000009760) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32249393 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1321316%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.155571955] (+0.000007200) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32256593 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Doam-ethernet-ppc64 path=3D/usr/imagestore//CXC1321316%3=5FSQFS396=
/bin/oam-ethernet-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.156145502] (+0.000573547) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32830140 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.158315902] (+0.002170400) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 35000540 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.158325315] (+0.000009413) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 35009953 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1321341%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.158332569] (+0.000007254) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 35017207 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dsw-installation-ppc64 path=3D/usr/imagestore//CXC1321341%3=5FSQFS=
396/bin/sw-installation-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.158847449] (+0.000514880) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 35532087 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.161316569] (+0.002469120) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 38001207 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.161326569] (+0.000010000) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 38011207 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1321315%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.161334435] (+0.000007866) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 38019073 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Doam-ipstack-ppc64 path=3D/usr/imagestore//CXC1321315%3=5FSQFS396/=
bin/oam-ipstack-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.161871235] (+0.000536800) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 38555873 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.164000942] (+0.002129707) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 40685580 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.164010782] (+0.000009840) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 40695420 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1321344%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.164017822] (+0.000007040) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 40702460 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dpm-support-ppc64 path=3D/usr/imagestore//CXC1321344%3=5FSQFS396/b=
in/pm-support-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.164576942] (+0.000559120) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 41261580 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.167097129] (+0.002520187) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 43781767 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.167107529] (+0.000010400) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 43792167 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1721176%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.167114462] (+0.000006933) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 43799100 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dpmagent-ppc64 path=3D/usr/imagestore//CXC1721176%3=5FSQFS396/bin/=
pmagent-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.167641689] (+0.000527227) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 44326327 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.205522915] (+0.037881226) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 82207553 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.205632755] (+0.000109840) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 82317393 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1737971=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistributio=
n=3D0x0 maxMem=3D0x0
" }
[15:12:43.205644169] (+0.000011414) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 82328807 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dliblscf-if.so path=3D/usr/imagestore//CXC1737971=5FSQFS396/lib/li=
blscf-if.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.207040435] (+0.001396266) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 83725073 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.210113289] (+0.003072854) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21234083351, timestamp=5Fend =3D 21293210124, con=
tent=5Fsize =3D 32600, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 86797927 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.210124462] (+0.000011173) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 86809100 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1320787%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.210181636] (+0.000057174) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 86866274 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dsysmgragent-ppc64 path=3D/usr/imagestore//CXC1320787%3=5FSQFS396/=
bin/sysmgragent-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.210769315] (+0.000587679) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 87453953 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.213078249] (+0.002308934) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 89762887 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.213088089] (+0.000009840) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 89772727 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1320782%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.213095742] (+0.000007653) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 89780380 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Deqm-resource-ppc64 path=3D/usr/imagestore//CXC1320782%3=5FSQFS396=
/bin/eqm-resource-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.213660595] (+0.000564853) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 90345233 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.216973662] (+0.003313067) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 93658300 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance information instanceId=
=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.216984356] (+0.000010694) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 93668994 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1720483%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistribut=
ion=3D0x0 maxMem=3D0x0
" }
[15:12:43.216992035] (+0.000007679) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 93676673 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dnclishell-ppc64 path=3D/usr/imagestore//CXC1720483%3=5FSQFS396/bi=
n/nclishell-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
" }
[15:12:43.217564275] (+0.000572240) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 94248913 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:1180", msg =3D "nrOfPgmInstances =3D0" }
[15:12:43.558584382] (+0.341020107) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "extended" : container =3D 31 ), v =3D { extend=
ed =3D { id =3D 7, timestamp =3D 21641670044 } } }, { process =3D "bmPgmCon=
fig", fileAndLine =3D "bm=5Fpgm=5Fconfig.c:756", msg =3D "Instance informat=
ion instanceId=3D0, hwDistribution=3D0, restartGroup=3D0" }
[15:12:43.558672596] (+0.000088214) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32704050 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:782", msg =3D "Created container list element wi=
th lmid=3DCXC1737954=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdistributio=
n=3D0x0 maxMem=3D0x0
" }
[15:12:43.558706169] (+0.000033573) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32737623 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibipcpbhregiproxy.so path=3D/usr/imagestore//CXC1737954=5FSQFS39=
6/lib/libipcpbhregiproxy.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.558717475] (+0.000011306) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32748929 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibipcpdhregiproxy.so path=3D/usr/imagestore//CXC1737954=5FSQFS39=
6/lib/libipcpdhregiproxy.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.558724142] (+0.000006667) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32755596 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibipcplhregiproxy.so path=3D/usr/imagestore//CXC1737954=5FSQFS39=
6/lib/libipcplhregiproxy.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.558732835] (+0.000008693) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32764289 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibippcmn.so path=3D/usr/imagestore//CXC1737954=5FSQFS396/lib/lib=
ippcmn.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.558740515] (+0.000007680) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32771969 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibipicmn.so path=3D/usr/imagestore//CXC1737954=5FSQFS396/lib/lib=
ipicmn.so instanceId=3D0 type=3D3 maxMem=3D0
" }
[15:12:43.558746862] (+0.000006347) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 32778316 } } }, { process =3D "bmPgmConfig", fileAndLin=
e =3D "bm=5Fpgm=5Fconfig.c:677", msg =3D "Created program list element with=
 handle=3Dlibapplregi.so path=3D/usr/imagestore//CXC1737954=5FSQFS396/lib/l=
ibapplregi.so instanceId=3D0 type=3D3 maFS396/lib/liboei.so instanceId=3D0 =
type=3D3 maxMem=3D0
" }
[15:12:43.580233920] (+0.021487058) oamhost com=5Fericsson=5Ftrithread:INFO=
: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, con=
tent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0, c=
pu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 7 ), v =3D { compact =
=3D { timestamp =3D 54265374 } } }, { process =3D "bmPgmConfi element with =
handle=3Dlibbhri.so path=3D/usr/imagestore//CXC1737954=5FSQFS396/lib/libbhr=
i.so instanceId=3D0 type=3D3 maxMem=3D0
", fileAndLine =3D "9=C3=B4X7bmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.c:677=
" }
[15:12:43.583797251] (+0.003563331) oamhost com=5Fericsson=5Ftrithread:TRAC=
E1: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, c=
ontent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0,=
 cpu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 8 ), v =3D { compac=
t =3D { timestamp =3D 57828705 } } }, { process =3D "ted program list eleme=
nt with handle=3Dlibgfm.so path=3D/usr/imagestore//CXC1737954=5FSQFS396/lib=
/libgfm.so instanceId=3D0 type=3D3 maxMem=3D0
", fileAndLine =3D "9=C3=B4p=C3=8CbmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.=
c:677" }
[15:12:43.583797251] (+0.000000000) oamhost com=5Fericsson=5Ftrithread:TRAC=
E1: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, c=
ontent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0,=
 cpu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 8 ), v =3D { compac=
t =3D { timestamp =3D 57828705 } } }, { process =3D "ted program list eleme=
nt with handle=3Dlibdepri-ip-lx-if.so path=3D/usr/imagestore//CXC1737954=5F=
SQFS396/lib/libdepri-ip-lx-if.so instanceId=3D0 type=3D3 maxMem=3D0
", fileAndLine =3D ":	\=E2=80=A1bmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.c:=
1180" }
[15:12:43.634123272] (+0.050326021) oamhost com=5Fericsson=5Ftrithread:TRAC=
E6: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, c=
ontent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0,=
 cpu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 13 ), v =3D { compa=
ct =3D { timestamp =3D 108154726 } } }, { process =3D "PgmInstances =3D0", =
fileAndLine =3D ":E=C3=99=02bmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.c:756"=
 }
[15:12:43.684202006] (+0.050078734) oamhost com=5Fericsson=5Ftrithread:TRAC=
E2: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, c=
ontent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0,=
 cpu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 9 ), v =3D { compac=
t =3D { timestamp =3D 24015732 } } }, { process =3D "ance information insta=
nceId=3D0, hwDistribution=3D0, restartGroup=3D0", fileAndLine =3D ":F=03=17=
bmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.c:782" }
[15:12:43.718014979] (+0.033812973) oamhost com=5Fericsson=5Ftrithread:TRAC=
E1: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, c=
ontent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0,=
 cpu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 8 ), v =3D { compac=
t =3D { timestamp =3D 57828705 } } }, { process =3D "ted container list ele=
ment with lmid=3DCXC1732000%3=5FSQFS396 instanceId=3D0 loadClass=3D200 hwdi=
stribution=3D0x0 maxMem=3D0x0
", fileAndLine =3D ":F!=E2=80=9AbmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.c:=
677" }
[15:12:43.718014979] (+0.000000000) oamhost com=5Fericsson=5Ftrithread:TRAC=
E1: { timestamp=5Fbegin =3D 21293210124, timestamp=5Fend =3D 21650212738, c=
ontent=5Fsize =3D 31984, packet=5Fsize =3D 32768, events=5Fdiscarded =3D 0,=
 cpu=5Fid =3D 4 }, { id =3D ( "compact" : container =3D 8 ), v =3D { compac=
t =3D { timestamp =3D 57828705 } } }, { process =3D "ted program list eleme=
nt with handle=3Devo-boot-mgr-ppc64 path=3D/usr/imagestore//CXC1732000%3=5F=
SQFS396/bin/evo-boot-mgr-ppc64 instanceId=3D0 type=3D1 maxMem=3D20000
", fileAndLine =3D ":OvBbmPgmConfig", msg =3D "bm=5Fpgm=5Fconfig.c:1180" }
[error] Unexpected end of packet. Either the trace data stream is corrupted=
 or metadata description does not match data layout.
[error] Reading event failed.
Error printing trace.

$=20
--=_mixed 0034E9D965257DF6_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_mixed 0034E9D965257DF6_=--
