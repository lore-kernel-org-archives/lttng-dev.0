From: Manikandan Govindaswamy <magov@vestas.com>
Subject: Re: No trace files are generated
Date: Thu, 5 Dec 2013 16:23:02 +0800
Message-ID: <6CFA219DE9CAD940989B83CA579159F91B43ACBAE5__11322.3434113481$1386621316$gmane$org@SGSINEXC014.vestas.net>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B28D8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxuP=ho9+D2EoSA_=b-w9JK55L3np7os5HvhkiEq6PWHYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.161])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <magov@vestas.com>) id 1VoUDM-0004cp-W5
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 03:23:30 -0500
In-Reply-To: <CA+jJMxuP=ho9+D2EoSA_=b-w9JK55L3np7os5HvhkiEq6PWHYw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks and It work now and able to get the kernel tracers.

Is there already any support for building the application with lttng tracep=
oint from Windows?

Or will I able to build using Cygwin for windows to generate -llttng-ust li=
brary?

Regards,
GMK

-----Original Message-----
From: jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com] On B=
ehalf Of J=E9r=E9mie Galarneau
Sent: Wednesday, December 04, 2013 10:05 PM
To: Thibault, Daniel
Cc: lttng-dev@lists.lttng.org; Manikandan Govindaswamy
Subject: Re: [lttng-dev] No trace files are generated

On Wed, Dec 4, 2013 at 9:34 AM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>> Date: Tue, 3 Dec 2013 11:01:05 -0500
>>
>> DEBUG1 [21408/21408]: Could not find any valid consumerd executable (in =
spawn_consumerd() at main.c:2119)
>> PERROR [21408/21408]: kernel start consumer exec: No such file or direct=
ory (in spawn_consumerd() at main.c:2224)
>> Error: Condition timed out. The consumer thread was never ready. Killing=
 it
>>
>> The session daemon can't find the consumer daemon executables. You will =
have to point the session daemon to them manually using the
>> --consumerd32-path or --consumerd64-path options (depending on your arch=
itecture).
>
>    The question then becomes why, when lttng-consumerd is missing, is the=
 lttng behaviour so different between kernel and user-space?  See bug #702 =
(http://bugs.lttng.org/issues/702).
>

Right. Thanks for creating a bug report.

J=E9r=E9mie

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
