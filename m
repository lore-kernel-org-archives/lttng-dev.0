From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: lttng command line user-friendliness
Date: Mon, 10 Sep 2012 17:39:09 +0200
Message-ID: <504E099D.6030407__15145.0160927654$1347291535$gmane$org@mentor.com>
References: <504DCE2E.7020000@mentor.com> <504E0082.9040502@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TB64C-0006uE-2D
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 11:38:28 -0400
In-Reply-To: <504E0082.9040502@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 09/10/2012 05:00 PM, David Goulet wrote:
> Issuing a sequence of commands like:
>
> lttng create lttng enable-event -u -a lttng start
> my_foobar_traced_application 1 2 3 lttng stop lttng destroy
>
> Small note here that the "destroy" is not needed. The stop forces a
> subbuffer switch meaning that the current data collected is written to
> the trace files.

Agreed, "destroy" is pointless. Also the user would want to have the =

result of "lttng record" visible when it runs "lttng list" afterwards.

> I would however encourage everyone on this list who is willing to
> continue this thread in order to come up with a small RFC for the command.
>
> RFC/Discussion:
>
> lttng record [--session-name <name>] [--session-template
> <session_template_file>]  -- <command> [<options>]
>
> Either "trace" or "record", I guess it's a simple aesthetic choice
> here :).

Using command name "trace" makes more sense. "record" does not go so =

well with "--live" (where nothing gets actually recorded).

So far [--session-template <session_template_file>] leaves open where to =

look for session_template_files if no absolute path is given. It might =

be good to also have a user specific directory (e.g. =

.lttng/session-templates) in addition to a system wide directory (e.g. =

/etc/lttng/session-templates).

--
Paul

> With more options here to set either a custom destination or live
> trace. What's the default? (no opts given). I would personally go for
> a default one being to record in the session default trace files and
> add a "-l" for the live.
>
> 	-o, --output=3DDST
> 	-l, --live
>
> Add a domain option where nothing enables kernel AND ust or else the
> command can take either -u or -k.
>
> Please, contribute to this, no bad ideas, only bad answers! :)
>
> Cheers and thanks Paul for comment!
> David
>
>> Thanks, Paul
>>
> -----BEGIN PGP SIGNATURE-----
>
> iQEcBAEBCgAGBQJQTgB+AAoJEELoaioR9I02zzoIAMd+nG8KLZnmHiFQU9Tcqq9Q
> N+jLVU/JjMuzjpQluD+1Xe3O9yLDu/mEqGAddYBQ5RnkHS7DveFwfY697nESqJPR
> qV0Y3ajbIC30WMrnweZSypsj9xAv33ZzFn4C/DuYIylicqpcX8mxcMgLzI9duoRQ
> /kxOqIeBLvl5C/pFSR55vki3fxhHPg67f2S9TgFDiBEPmaL0UkxpfOaB3G86Bj8z
> Kp7oKCCbQzv0R3J4BlcNRNUXKTClo3Qjb/ZyWGgFwwErZJoADcd+osvIU9raA7MY
> yEEExx5t4OMjEyrb3eqJgihH+xMx6eW1275vz2TV4ayBIg1YuJrIzUY/zgVkYn0=3D
> =3Df6QB
> -----END PGP SIGNATURE-----


-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
