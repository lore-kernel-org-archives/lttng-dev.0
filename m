From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: babeltrace -i ?
Date: Tue, 7 May 2013 10:43:21 -0400
Message-ID: <CA+jJMxvTWsm5HZuZYoTm1iAPRgNkAmj_BqEmj=Cr8TxnujOFfQ__29448.7212122933$1367937844$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD01CF4B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<20130507134316.GA5118@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UZj75-0002RH-B5
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 10:43:31 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey16so3849201wid.6
	for <lttng-dev@lists.lttng.org>; Tue, 07 May 2013 07:43:25 -0700 (PDT)
In-Reply-To: <20130507134316.GA5118@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Thibault,
	Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Fixed by:

commit 05cab52530332c97aca9d8c78a8cae2f82f00896
Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Thu Feb 28 21:27:45 2013 -0500

    Fix: Ensure the specified input format is CTF

    Add a check to make sure the input trace format argument passed to the
    babeltrace converter is "ctf" as it is currently the only one supported.

    Add a note to this effect in the man page.

    Fixes #462

    Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

On Tue, May 7, 2013 at 9:43 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Yep, a clearer error message could help. please file a bug on
> bugs.lttng.org.
>
> * Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>>    What is the babeltrace -i, --input-format option meant for?  At first=
 I thought one could round-trip a CTF trace to text and back using babeltra=
ce, but if I try this:
>>
>> $ babeltrace /path_to_the/ctf_trace_directory -w /path_to_the/text_trace=
_file
>> $ babeltrace /path_to_the/text_trace_file -i text -o ctf -w /path_to_the=
/reconstituted_ctf_trace_directory
>>
>>    The second command gives me:
>>
>> [error] Cannot open any trace for reading.
>> [error] opening trace "/path_to_the/text_trace_file" for reading.
>> [error] none of the specified trace paths could be opened.
>>
>>    If '-i ctf' is the only currently-implemented option, then we should =
get a more appropriate error message when using another: something along th=
e lines of "babeltrace input format not supported ".
>>
>> Daniel U. Thibault
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence =
R&D Canada - Valcartier (DRDC Valcartier)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critic=
al Cyber Security (MCCS)
>> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & =
Countermeasures (SPC)
>> 2459 route de la Bravoure
>> Qu=E9bec, QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada / Government of Canada
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
