From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Unsynchronized access in
	LTTngTCPSessiondClient
Date: Sat, 22 Feb 2014 15:19:15 -0500
Message-ID: <CA+jJMxukg5xB-DEVV3M23piN8sMB2uqvt+rLs375ocRk61ndAQ__35319.1678681926$1393100426$gmane$org@mail.gmail.com>
References: <1392913353-13369-1-git-send-email-jeremie.galarneau@efficios.com>
	<204474029.28925.1393099864388.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WHJ2f-0003F7-IG
	for lttng-dev@lists.lttng.org; Sat, 22 Feb 2014 15:19:27 -0500
Received: by mail-qc0-f181.google.com with SMTP id c9so7192424qcz.40
	for <lttng-dev@lists.lttng.org>; Sat, 22 Feb 2014 12:19:16 -0800 (PST)
In-Reply-To: <204474029.28925.1393099864388.JavaMail.zimbra@efficios.com>
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

On Sat, Feb 22, 2014 at 3:11 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Other comments,
>
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
>
> I'd prefer:
>
>   private List<LTTngEvent> enabledEventList =3D
>          Collections.synchronizedList(new ArrayList<LTTngEvent>());
>
> unless you tell me that your coding style is more "java-like".
>
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
>
> inconsistent style, missing space after "synchronized".
>
>> +                                     tmpList =3D new ArrayList<LTTngEve=
nt>(enabledEventList);
>> +                             }
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
>
> Hrm, so what we want here is probably more a set than a list ? We want a =
data structure
> that does not have duplicates. If we can confirm that the order of the el=
ements does not
> matter, a hash map might be a much more suited data structure than a list=
. We could
> then remove the explicit synchronize around "add".

Makes sense, I guess David (original author) will probably have an
opinion on that. My immediate concern was addressing the code's thread
safety.

Regards,
J=E9r=E9mie

>
> Thanks,
>
> Mathieu
>
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
