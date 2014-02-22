From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Unsynchronized access in
	LTTngTCPSessiondClient
Date: Sat, 22 Feb 2014 14:15:15 -0500
Message-ID: <CA+jJMxs549OwuD6QBvF6nHW8M0tHyZxcMb0oHJ6okCt4TdoY_Q__20230.3223930814$1393096589$gmane$org@mail.gmail.com>
References: <1392913353-13369-1-git-send-email-jeremie.galarneau@efficios.com>
	<1530478584.28856.1393085579318.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WHI2j-0002gp-GD
	for lttng-dev@lists.lttng.org; Sat, 22 Feb 2014 14:15:27 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so7434083qcq.8
	for <lttng-dev@lists.lttng.org>; Sat, 22 Feb 2014 11:15:16 -0800 (PST)
In-Reply-To: <1530478584.28856.1393085579318.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sat, Feb 22, 2014 at 11:12 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
>> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Thursday, February 20, 2014 11:22:33 AM
>> Subject: [lttng-dev] [PATCH lttng-ust] Fix: Unsynchronized access in  LT=
TngTCPSessiondClient
>>
>> enabledEventList is shared between the LTTngThread and eventTimer
>> threads but is not synchronized.
>>
>> This patch changes enabledEventList's type from an ArrayList to a
>> synchronizedList which implements the same interface.
>>
>> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
>> ---
>>  .../org/lttng/ust/jul/LTTngTCPSessiondClient.java         | 15
>>  +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.j=
ava
>> b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
>> index 25d1cb2..0d9a485 100644
>> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
>> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
>> @@ -34,6 +34,7 @@ import java.util.List;
>>  import java.util.Timer;
>>  import java.util.TimerTask;
>>  import java.util.logging.Logger;
>> +import java.util.Collections;
>>
>>  class USTRegisterMsg {
>>       public static int pid;
>> @@ -57,7 +58,8 @@ public class LTTngTCPSessiondClient {
>>       private Semaphore registerSem;
>>
>>       private Timer eventTimer;
>> -     private List<LTTngEvent> enabledEventList =3D new ArrayList<LTTngE=
vent>();
>> +     private List<LTTngEvent> enabledEventList =3D Collections.synchron=
izedList(
>> +             new ArrayList<LTTngEvent>());
>>       /*
>>        * Map of Logger objects that have been enabled. They are indexed =
by name.
>>        */
>> @@ -86,7 +88,10 @@ public class LTTngTCPSessiondClient {
>>                                * We have to make a copy here since it is=
 possible that the
>>                                * enabled event list is changed during an=
 iteration on it.
>>                                */
>> -                             List<LTTngEvent> tmpList =3D new ArrayList=
<LTTngEvent>(enabledEventList);
>> +                             List<LTTngEvent> tmpList;
>> +                             synchronized(enabledEventList) {
>> +                                     tmpList =3D new ArrayList<LTTngEve=
nt>(enabledEventList);
>> +                             }
>
>
> Further down in this function, we find:
>
>                                         ret =3D enableCmd.enableLogger(ha=
ndler, event, enabledLoggers);
>                                         if (ret =3D=3D 1) {
>                                                 /* Enabled so remove the =
event from the list. */
>                                                 enabledEventList.remove(e=
vent);
>                                         }
>
> should we encompass a larger part of this function with synchronize ?

AFAIU, this operation is already synchronized by the synchronizedList class.

> What happens if event is removed from enabledEventList while we iterate o=
n the list copy ?

I'm not sure I understand your concern.

Regards,
J=E9r=E9mie

>
> Thanks,
>
> MAthieu
>
>
>>
>>                               LTTngSessiondCmd2_4.sessiond_enable_handle=
r enableCmd =3D new
>>                                       LTTngSessiondCmd2_4.sessiond_enabl=
e_handler();
>> @@ -277,8 +282,10 @@ public class LTTngTCPSessiondClient {
>>                                                * Add the event to the li=
st so it can be enabled if
>>                                                * the logger appears at s=
ome point in time.
>>                                                */
>> -                                             if (enabledEventList.conta=
ins(event) =3D=3D false) {
>> -                                                     enabledEventList.a=
dd(event);
>> +                                             synchronized (enabledEvent=
List) {
>> +                                                     if (enabledEventLi=
st.contains(event) =3D=3D false) {
>> +                                                             enabledEve=
ntList.add(event);
>> +                                                     }
>>                                               }
>>                                       }
>>                                       data =3D enableCmd.getBytes();
>> --
>> 1.9.0
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
