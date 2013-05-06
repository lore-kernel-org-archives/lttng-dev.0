From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: WG: Reading CTF trace using Babeltrace API
Date: Mon, 6 May 2013 16:17:09 -0400
Message-ID: <CA+jJMxteAA-ve09nNuXvASeohWOMsy5hJRdEx=P-x-qCgDvxDg__2935.12101420692$1367871473$gmane$org@mail.gmail.com>
References: <E537659DE2B2C54EBD9FC9180F059880390314AC9D@zulu.esk.fraunhofer.de>
	<20130502204349.GH15675@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UZRqV-0001TM-Vw
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 16:17:16 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm14so2959761wib.5
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 13:17:10 -0700 (PDT)
In-Reply-To: <20130502204349.GH15675@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "jdesfossez@efficios.com" <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Thu, May 2, 2013 at 4:43 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> J=E9r=E9mie, can you have a look at these questions ?
>
> Thanks,
>
> Mathieu
>
> * Salman Rafiq (salman.rafiq@esk.fraunhofer.de) wrote:
>> Hello All,
>>
>> In continuation to my previous questions related to reading CTF traces f=
rom particular timestamp, I can now further summarize few problems/question=
s I have:
>>
>>
>> 1.       Is it possible to seek CTF file_stream using 'begin' and 'end' =
iterator position i.e. BT_SEEK_TIME?
>>

I'm not sure I understand your question. The iterator API provides a
seeking mechanism that accepts time-based positions expressed in
nanoseconds (with bt_iter_pos.type =3D=3D BT_SEEK_TIME) and
BT_SEEK_BEGIN/BT_SEEK_LAST.

See bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos
*iter_pos) (include/babeltrace/iterator.h:114)

>>
>>
>> a.       We cannot use babel trace API for CTF iterator creation using d=
efined start and end position based on time. Seems this is in progress?

It is supported via the position parameters of bt_ctf_iter_create
(include/babeltrace/ctf/iterator.h:62). Are you getting an error?

>>
>> b.      The other possible solution I am using, is to create the iterato=
r using defaults, and then later use API to 'create iterator time position =
based on Raw Timestamp (only takes raw time)' and then 'set iterator positi=
on to that timed position'.
>>

This should work too.

>>
>>
>> 2.       But, since the area of interest for me was only the time when u=
ser application which I am tracing using Lttng-kernel tracer, started recor=
ding events (application use external trace recording format).
>>
>> User application contains a definition file which tells me the epoch tim=
e (us resolution) when it started and stopped tracing. I wanted to use this=
 information to set iterator positions.
>>
>>
>>
>> a.       Question is Can I convert this time to raw time which babeltrac=
e API takes as an argument?
>>
>> b.      Or Is there any way to read Clock struct from CTF metadata file =
(is there any scope defined for this), so that I can extract offset variabl=
e value to convert epoch time from other trace to raw time?
>>

Yes. I suggest you have a look at what the ctf-text plugin does in
ctf_text_write_event[1] and perhaps ctf_get_real_timestamp[2] to
understand these time conversions.

Regards,
J=E9r=E9mie

[1] formats/ctf-text/ctf-text.c:272
[2] formats/ctf/events-private.h:38

>>
>> It will be really great if I can get few suggestions/help related to the=
se issues.
>> Thanking in anticipation!
>>
>>
>> Best Regards,
>>
>> Salman Rafiq
>> Research Engineer
>> Industrial Communication
>> Fraunhofer-Einrichtung f=FCr Systeme der Kommunikationstechnik ESK
>>
>> Hansastra=DFe 32 | 80686 M=FCnchen
>> Telefon, Fax:  +49 89 547088-356 | +49 89 547088-66-356
>> E-Mail:   salman.rafiq@esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
>>
>> Internet:
>> http://www.esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
>> http://www.facebook.com/FraunhoferESK
>> http://www.twitter.com/FraunhoferESK
>>
>> Von: Salman Rafiq [mailto:salman.rafiq@esk.fraunhofer.de]
>> Gesendet: Mittwoch, 18. Juli 2012 15:28
>> An: lttng-dev@lists.lttng.org
>> Betreff: [lttng-dev] Reading CTF trace from time T
>>
>> Hello All,
>>
>> I am tracing a user application using lttng kernel tracer, i.e.,
>>
>> Start lttng kernel trace
>> ./application
>> Stop lttng kernel trace
>>
>> Before I was reading kernel CTF trace using babeltrace API's from beginn=
ing of trace, e.g.,
>> struct  bt_iter_pos  begin_pos
>> struct bt_ctf_iter *iterator
>>
>> begin_pos.type =3D BT_SEEK_BEGIN
>> iterator =3D create_iterator(context,  &begin_pos, NULL)
>> .. and then read events start from that iterator postion.
>>
>> Recently, I have been trying to seek trace using timestamp from when the=
 application started to application end.
>> I would like to know if I am doing it right. Would the method below enou=
gh to achieve this? Or I am missing something here :-S
>>
>> begin_pos.type =3D BT_SEEK_TIME
>> end_pos.type =3D BT_SEEK_TIME
>>
>> begin_pos.u.seek_time =3D timestamp1 (for now manually taken from CTF ke=
rnel trace when application started)
>> end_pos.u.seek_time =3D timestamp2 (for now manually taken from CTF kern=
el trace when application ended)
>>
>> iterator =3D create_iterator(context,  &begin_pos, &end_pos);
>> and then with reading events at iterator position until end_pos.
>>
>>
>> I am using babeltrace package version "1.0.0-pre4".
>> Any help related to achieving this functionality will be highly apprecia=
ted.
>>
>> Best Regards,
>> Salman
>>
>>
>> --
>> Salman Rafiq
>> Industrial Communication
>> Fraunhofer-Einrichtung f=FCr Systeme der Kommunikationstechnik ESK
>>
>> Hansastra=DFe 32 | 80686 M=FCnchen
>> Telefon, Fax:  +49 89 547088-356 | +49 89 547088-66-356
>> E-Mail:   salman.rafiq@esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
>>
>> Internet:
>> http://www.esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
>> http://www.facebook.com/FraunhoferESK
>> http://www.twitter.com/FraunhoferESK
>>
>
> Content-Description: ATT00001.txt
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
