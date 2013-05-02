From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: WG: Reading CTF trace using Babeltrace API
Date: Thu, 2 May 2013 16:43:49 -0400
Message-ID: <20130502204349.GH15675__5458.07882813296$1367527464$gmane$org@Krystal>
References: <E537659DE2B2C54EBD9FC9180F059880390314AC9D@zulu.esk.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY0M3-0006Yh-KV
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:43:51 -0400
Content-Disposition: inline
In-Reply-To: <E537659DE2B2C54EBD9FC9180F059880390314AC9D@zulu.esk.fraunhofer.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Salman Rafiq <salman.rafiq@esk.fraunhofer.de>, jeremie.galarneau@efficios.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "jdesfossez@efficios.com" <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

J=E9r=E9mie, can you have a look at these questions ?

Thanks,

Mathieu

* Salman Rafiq (salman.rafiq@esk.fraunhofer.de) wrote:
> Hello All,
> =

> In continuation to my previous questions related to reading CTF traces fr=
om particular timestamp, I can now further summarize few problems/questions=
 I have:
> =

> =

> 1.       Is it possible to seek CTF file_stream using 'begin' and 'end' i=
terator position i.e. BT_SEEK_TIME?
> =

> =

> =

> a.       We cannot use babel trace API for CTF iterator creation using de=
fined start and end position based on time. Seems this is in progress?
> =

> b.      The other possible solution I am using, is to create the iterator=
 using defaults, and then later use API to 'create iterator time position b=
ased on Raw Timestamp (only takes raw time)' and then 'set iterator positio=
n to that timed position'.
> =

> =

> =

> 2.       But, since the area of interest for me was only the time when us=
er application which I am tracing using Lttng-kernel tracer, started record=
ing events (application use external trace recording format).
> =

> User application contains a definition file which tells me the epoch time=
 (us resolution) when it started and stopped tracing. I wanted to use this =
information to set iterator positions.
> =

> =

> =

> a.       Question is Can I convert this time to raw time which babeltrace=
 API takes as an argument?
> =

> b.      Or Is there any way to read Clock struct from CTF metadata file (=
is there any scope defined for this), so that I can extract offset variable=
 value to convert epoch time from other trace to raw time?
> =

> =

> It will be really great if I can get few suggestions/help related to thes=
e issues.
> Thanking in anticipation!
> =

> =

> Best Regards,
> =

> Salman Rafiq
> Research Engineer
> Industrial Communication
> Fraunhofer-Einrichtung f=FCr Systeme der Kommunikationstechnik ESK
> =

> Hansastra=DFe 32 | 80686 M=FCnchen
> Telefon, Fax:  +49 89 547088-356 | +49 89 547088-66-356
> E-Mail:   salman.rafiq@esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
> =

> Internet:
> http://www.esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
> http://www.facebook.com/FraunhoferESK
> http://www.twitter.com/FraunhoferESK
> =

> Von: Salman Rafiq [mailto:salman.rafiq@esk.fraunhofer.de]
> Gesendet: Mittwoch, 18. Juli 2012 15:28
> An: lttng-dev@lists.lttng.org
> Betreff: [lttng-dev] Reading CTF trace from time T
> =

> Hello All,
> =

> I am tracing a user application using lttng kernel tracer, i.e.,
> =

> Start lttng kernel trace
> ./application
> Stop lttng kernel trace
> =

> Before I was reading kernel CTF trace using babeltrace API's from beginni=
ng of trace, e.g.,
> struct  bt_iter_pos  begin_pos
> struct bt_ctf_iter *iterator
> =

> begin_pos.type =3D BT_SEEK_BEGIN
> iterator =3D create_iterator(context,  &begin_pos, NULL)
> .. and then read events start from that iterator postion.
> =

> Recently, I have been trying to seek trace using timestamp from when the =
application started to application end.
> I would like to know if I am doing it right. Would the method below enoug=
h to achieve this? Or I am missing something here :-S
> =

> begin_pos.type =3D BT_SEEK_TIME
> end_pos.type =3D BT_SEEK_TIME
> =

> begin_pos.u.seek_time =3D timestamp1 (for now manually taken from CTF ker=
nel trace when application started)
> end_pos.u.seek_time =3D timestamp2 (for now manually taken from CTF kerne=
l trace when application ended)
> =

> iterator =3D create_iterator(context,  &begin_pos, &end_pos);
> and then with reading events at iterator position until end_pos.
> =

> =

> I am using babeltrace package version "1.0.0-pre4".
> Any help related to achieving this functionality will be highly appreciat=
ed.
> =

> Best Regards,
> Salman
> =

> =

> --
> Salman Rafiq
> Industrial Communication
> Fraunhofer-Einrichtung f=FCr Systeme der Kommunikationstechnik ESK
> =

> Hansastra=DFe 32 | 80686 M=FCnchen
> Telefon, Fax:  +49 89 547088-356 | +49 89 547088-66-356
> E-Mail:   salman.rafiq@esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
> =

> Internet:
> http://www.esk.fraunhofer.de<http://www.esk.fraunhofer.de/>
> http://www.facebook.com/FraunhoferESK
> http://www.twitter.com/FraunhoferESK
> =


Content-Description: ATT00001.txt
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
