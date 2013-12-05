From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: RFC LTTng session and daemon configuration save and
	restore
Date: Thu, 5 Dec 2013 14:49:56 -0500
Message-ID: <CA+jJMxuknEVPT5eWADUPzfir12U9kh_p2KTqOYY03G3_52ftbw__31478.3734422692$1386273056$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B2BDC@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Voevy-000227-6b
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 14:50:07 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so138760qac.14
	for <lttng-dev@lists.lttng.org>; Thu, 05 Dec 2013 11:49:56 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267B2BDC@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 5, 2013 at 1:45 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>> Date: Wed, 4 Dec 2013 16:33:09 -0500
>>
>> Version:
>> - v0.2: 04/12/2013
>> [...]
>> Daemon configuration files are, by default, either stored system-wide un=
der /etc/lttng/*.conf or in the user's home directory under $HOME/.lttng/*.=
conf.
>
>    Transient files  (lttng-sessiond.pid, etc., but not .lttngrc) are curr=
ently created under $HOME/.lttng/ (match) and /run/lttng/ (mismatch).  But =
I guess the difference between /run and /etc makes sense in this case.
>
>> Load sessions. If url the is a directory, all .lttng files it contains w=
ill be loaded. If session_name is NULL, all sessions found in url are resto=
red.
>
> =AB If url the is a directory =BB?
>
>> int lttng_save_sessions(const char *url, const char *session_name int fl=
ags/struct lttng_session_save_attr *attr);
>
>    Missing commas.
>
Will fix, thanks.

>> If a session was saved as active, the tracing for that session will be a=
ctivated automatically on load. [...]
>> Tracing sessions saved in an active state will be resumed on load.
>
>    But what if the trace files have gone missing in the mean time?  I thi=
nk newly-loaded sessions should create new trace folders altogether (let th=
e user decide how to merge the trace folders later).  This would be a good =
occasion to resolve the recurring problem of trace folder collisions (e.g. =
when a user-space app being traced per-processID dlcloses and dlopens its t=
race provider within a one-second window).  A simple solution is to use the=
 snapshot approach, and have a "-%d" sequential sub-index added to the trac=
e folder name to avoid the collision.
>    Or is the intent to have the conf files store only the "name" part of =
the sessions, without the timestamp part?  This prevents collisions only wh=
en the session is not configured with an output or set-url option.
>

Very good point. We should handle it like the snapshot option does
("-%d"). Since "auto-" is a reserved session name, we will be able to
create a new "default name" on load if the user never specified a
session name.

Thanks,
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
