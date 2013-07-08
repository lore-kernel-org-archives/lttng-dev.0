From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Check for invalid
	commands	in print_cmd
Date: Mon, 8 Jul 2013 11:47:03 -0400
Message-ID: <20130708154703.GK29362__35814.8671723486$1373298459$gmane$org@Krystal>
References: <1370293160-22212-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwDea-0006CM-NB
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 11:47:04 -0400
Content-Disposition: inline
In-Reply-To: <1370293160-22212-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Corrupted "ustcomm_ust_msg" received by the listener thread could cause a=
n out
> of bounds access to the cmd_name_mapping array in the traced application.
> =

> While this doesn't fix the root cause of the problem, this check should b=
e put
> in place anyway since corrupted messages are not checked for and may brin=
g down
> the tracee.

FYI, this had been fixed by another patch:

commit fd67a0045e800401532c095588a1fe5d452a4777
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Jun 17 11:19:22 2013 -0400

    Fix: segfault when print invalid command
    =

    Fixes #556
    =

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


> =

> Fixes #556
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  liblttng-ust/lttng-ust-comm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index ae2e518..1be693f 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -208,8 +208,9 @@ static
>  void print_cmd(int cmd, int handle)
>  {
>  	const char *cmd_name =3D "Unknown";
> +	int cmd_name_mapping_len =3D sizeof(cmd_name_mapping) / sizeof(char *);
>  =

> -	if (cmd_name_mapping[cmd]) {
> +	if (cmd < cmd_name_mapping_len && cmd_name_mapping[cmd]) {
>  		cmd_name =3D cmd_name_mapping[cmd];
>  	}
>  	DBG("Message Received \"%s\", Handle \"%s\" (%d)", cmd_name,
> -- =

> 1.8.2.3
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
