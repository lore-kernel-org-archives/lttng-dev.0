From: Alexis Martin <alexis.martin@inria.fr>
Subject: Unable to read events using babeltrace C library
Date: Thu, 25 Feb 2016 18:31:53 +0100
Message-ID: <7A37911F-21D2-4CBC-B8EF-019EF09D8E3E__42543.8914252028$1456424418$gmane$org@inria.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============1295955295=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexis.martin@inria.fr>) id 1aYzlf-000723-Mj
 for lttng-dev@lists.lttng.org; Thu, 25 Feb 2016 12:32:05 -0500
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


--===============1295955295==
Content-Type: multipart/alternative; boundary="Apple-Mail=_5E229D21-0AAD-46DE-849C-D63F79C4B566"


--Apple-Mail=_5E229D21-0AAD-46DE-849C-D63F79C4B566
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I want to use the babeltrace C library to read a CTF trace in my =
program, but I=E2=80=99m facing some problems.

I was able to create a bt_context and load a trace (I can get the begin =
and end timestamps).
But then, it seems some functions are missing in the library headers:

The API.txt file in the doc folder says:

> A CTF event is obtained from an iterator via the =
bt_ctf_iter_read_event()
> function or via the call_data parameter of a callback. To read the =
data of a
> CTF event :
> 	* bt_ctf_event_name() 		returns the name of the event;
> 	* bt_ctf_get_timestamp() 	returns the timestamp of the =
event
> 					offsetted with the system clock
> 					source (in ns);
> 	* bt_ctf_get_cycles() 		returns the timestamp of the =
event as
> 					written in the packet (in =
cycles).


Those functions were defined in the include/babeltrace/ctf/events.h file =
but they were moved in file include/babeltrace/ctf/events-internal.h =
(commit 9a19a512f564cbb301b0b5f1377d64e3b3f0a851) which is not part of =
the include files when installing babeltrace.
Is it normal and the way to access events data has changed ? (The the =
API.txt file is quite old)
I read on babeltrace website that the version 2 will provide a new API.

Also when I iterate over events the event pointer never changes:

>     // get iterator of events
>     struct bt_ctf_iter *envents_iter =3D bt_ctf_iter_create(ctx, =
nullptr, nullptr);
>     //event pointer
>     struct bt_ctf_event *ev_ptr =3D nullptr;
>    =20
>     while(true){
>         ev_ptr =3D bt_ctf_iter_read_event(envents_iter);
>         if(! ev_ptr)
>             break;
>         bt_iter_next(bt_ctf_get_iter(envents_iter));
>     }
       =20
Can you tell me if I misuse this library ?
Thanks!
=E2=80=94
Alexis Martin
PhD. Student
INRIA / LIG POLARIS-Team


--Apple-Mail=_5E229D21-0AAD-46DE-849C-D63F79C4B566
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi,<div class=3D""><br class=3D""></div><div class=3D"">I =
want to use the babeltrace C library to read a CTF trace in my program, =
but I=E2=80=99m facing some problems.</div><div class=3D""><br =
class=3D""></div><div class=3D""><div class=3D"">I was able to create =
a&nbsp;bt_context and load a trace (I can get the begin and end =
timestamps).</div><div class=3D"">But then, it seems some functions are =
missing in the library headers:</div></div><div class=3D""><br =
class=3D""></div><div class=3D"">The API.txt file in the doc folder =
says:</div><div class=3D""><br class=3D""></div><div =
class=3D""><blockquote type=3D"cite" class=3D"">A CTF event is obtained =
from an iterator via the bt_ctf_iter_read_event()<br class=3D"">function =
or via the call_data parameter of a callback. To read the data of a<br =
class=3D"">CTF event :<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>* bt_ctf_event_name() <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>returns the name of the event;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>* =
bt_ctf_get_timestamp() <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>returns the timestamp of the =
event<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">					=
</span>offsetted with the system clock<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span>source (in ns);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>* =
bt_ctf_get_cycles() <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>returns the timestamp of =
the event as<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">					=
</span>written in the packet (in cycles).</blockquote></div><div =
class=3D""><br class=3D""></div><div class=3D"">Those functions were =
defined in the&nbsp;include/babeltrace/ctf/events.h file but they were =
moved in file =
include/babeltrace/ctf/events-internal.h&nbsp;(commit&nbsp;9a19a512f564cbb=
301b0b5f1377d64e3b3f0a851) which is not part of the include files when =
installing babeltrace.</div><div class=3D"">Is it normal and the way to =
access events data has changed ? (The the API.txt file is quite =
old)</div><div class=3D"">I read on babeltrace website that the version =
2 will provide a new API.</div><div class=3D""><br class=3D""></div><div =
class=3D"">Also when I iterate over events the&nbsp;event pointer never =
changes:</div><div class=3D""><br class=3D""></div><div =
class=3D""></div><blockquote type=3D"cite" class=3D""><div =
class=3D"">&nbsp; &nbsp; // get iterator of events<br class=3D"">&nbsp; =
&nbsp;&nbsp;struct&nbsp;bt_ctf_iter&nbsp;*envents_iter =
=3D&nbsp;bt_ctf_iter_create(ctx,&nbsp;nullptr,&nbsp;nullptr);</div><div =
class=3D"">&nbsp; &nbsp; //event pointer<br class=3D"">&nbsp; =
&nbsp;&nbsp;struct&nbsp;bt_ctf_event&nbsp;*ev_ptr =3D&nbsp;nullptr;<br =
class=3D"">&nbsp; &nbsp;&nbsp;<br class=3D"">&nbsp; =
&nbsp;&nbsp;while(true){<br class=3D"">&nbsp; &nbsp; &nbsp; =
&nbsp;&nbsp;ev_ptr =3D&nbsp;bt_ctf_iter_read_event(envents_iter);<br =
class=3D""></div></blockquote><blockquote type=3D"cite" class=3D""><div =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; if(! ev_ptr)</div><div =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</div><div =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
bt_iter_next(bt_ctf_get_iter(envents_iter));</div></blockquote><blockquote=
 type=3D"cite" class=3D""><div class=3D"">&nbsp; &nbsp; =
}</div></blockquote><div class=3D"">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br =
class=3D""></div><div class=3D"">Can you tell me if I misuse this =
library ?</div><div class=3D"">Thanks!</div><div class=3D"">=E2=80=94</div=
><div class=3D""><div class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">Alexis Martin<br class=3D"">PhD. =
Student</div><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">INRIA / LIG POLARIS-Team</div></div></div></div></div>
</div>
<br class=3D""></div></body></html>=

--Apple-Mail=_5E229D21-0AAD-46DE-849C-D63F79C4B566--


--===============1295955295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1295955295==--
