From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RELEASE] LTTng Tools 2.2.0 - Cuda (STABLE)
Date: Wed, 26 Jun 2013 10:32:00 -0400
Message-ID: <CA+jJMxtiBRKbxUVGvLPbK4ChB1PZHi2CZvAurHFK6oLC8rMJ=A__33009.8954299048$1372257222$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD131436D4@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<20130626124914.GA28225@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UrqlS-000541-Kc
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 10:32:06 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so1938421wiw.1
	for <lttng-dev@lists.lttng.org>; Wed, 26 Jun 2013 07:32:00 -0700 (PDT)
In-Reply-To: <20130626124914.GA28225@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Thibault,
	Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 26, 2013 at 8:49 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>> -----Message d'origine-----
>> Message: 5
>> Date: Tue, 25 Jun 2013 17:37:57 -0400
>> From: David Goulet <dgoulet@efficios.com>
>> [...]
>> Per UID buffers makes every application sharing the same UID to use the =
same
>> buffers.
>> [...]
>> Also, the buffers for UST application are now created in the consumer
>> and passed to the application. Thus, the buffer ownership has been
>> transfered from the UST tracer to the consumer.
>> ------------------------------
>> Message: 8
>> Date: Tue, 25 Jun 2013 19:01:17 -0400
>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> [...]
>> - Buffers shared across applications with same user id e.g.
>>   lttng enable-channel -u mychan --buffers-uid
>> ------------------------------
>>
>>    How can per-uid UST buffers be owned by any one application?
>
> It is not the case, I do not understand the question.
>
> Per-PID buffers are per "application", and per-PID buffers are shared
> across all applications with the same user id.

Typo, Mathieu meant "per-UID buffers are shared across all
applications with the same user id."

>
> Thanks,
>
> Mathieu
>
>>
>> Daniel U. Thibault
>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & =
Countermeasures (SPC)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critic=
al Cyber Security (MCCS)
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence =
R&D Canada - Valcartier (DRDC Valcartier)
>> 2459 route de la Bravoure
>> Qu=E9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
