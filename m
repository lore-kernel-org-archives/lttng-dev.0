From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] relayd pipes and
	error	handling
Date: Fri, 20 Jul 2012 14:15:11 -0400
Message-ID: <20120720181511.GC20073__19654.0698096671$1342808131$gmane$org@Krystal>
References: <CAGDH53nAXuZB20+LdogwiYZdiCrqEdZhSZZH9f4i28_wA8nJtg@mail.gmail.com>
	<5006DC53.1040709@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SsHjM-00007i-Rg
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 14:15:12 -0400
Content-Disposition: inline
In-Reply-To: <5006DC53.1040709@efficios.com>
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

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> I'm pretty OK with that.
> 
> I have utils_* function for that in lttng-sessiond/ ... I think I'm
> going to move them to common/ since they are pretty useful for the
> complete code tree.

since this was a RFC patch, does Christian need to resend it, after
update ?

> 
> Cheers!
> David
> 
> Christian Babeux:
> > Hi,
> > 
> > The current relayd employ two set of pipes for command relaying
> > and thread quit signalling. The relay_cmd_pipe pipes are never
> > closed. Also, the thread_quit_pipe pipes are not closed in some
> > error cases (fail to parse args, fail to daemonize, etc.). Here is
> > a proposed way to cleanup and handle error cases.
> > 
> > Thoughts?
> > 
> > Thanks,
> > 
> > Christian
> > 
> > Fix: relayd relay_cmd_pipe/thread_quit_pipe should be closed on
> > exit/error.
> > 
> > diff --git a/src/bin/lttng-relayd/main.c
> > b/src/bin/lttng-relayd/main.c index acc6ca8..55452b3 100644 ---
> > a/src/bin/lttng-relayd/main.c +++ b/src/bin/lttng-relayd/main.c @@
> > -231,14 +231,26 @@ void cleanup(void)
> > 
> > DBG("Cleaning up");
> > 
> > +       /* Close thread quit pipes */ for (i = 0; i < 2; i++) { if
> > (thread_quit_pipe[i] >= 0) { ret = close(thread_quit_pipe[i]); if
> > (ret) { -                               PERROR("close"); +
> > PERROR("close quit pipe"); } } } + +       /* Close relay cmd pipes
> > */ +       for (i = 0; i < 2; i++) { +               if
> > (relay_cmd_pipe[i] >= 0) { +                       ret =
> > close(relay_cmd_pipe[i]); +                       if (ret) { +
> > PERROR("close cmd pipe"); +                       } +
> > } +       } + }
> > 
> > /* @@ -1479,7 +1491,7 @@ int main(int argc, char **argv) /* Parse
> > arguments */ progname = argv[0]; if ((ret = parse_args(argc, argv)
> > < 0)) { -               goto error; +               goto exit; }
> > 
> > if ((ret = set_signal_handler()) < 0) { @@ -1491,7 +1503,7 @@ int
> > main(int argc, char **argv) ret = daemon(0, 0); if (ret < 0) { 
> > PERROR("daemon"); -                       goto error; +
> > goto exit; } }
> > 
> > @@ -1502,7 +1514,7 @@ int main(int argc, char **argv) if
> > (control_uri->port < 1024 || data_uri->port < 1024) { ERR("Need to
> > be root to use ports < 1024"); ret = -1; -
> > goto error; +                       goto exit; } }
> > 
> > @@ -1567,6 +1579,7 @@ exit: if (!ret) { exit(EXIT_SUCCESS); } + 
> > error: exit(EXIT_FAILURE); }
> > 
> > _______________________________________________ lttng-dev mailing
> > list lttng-dev@lists.lttng.org 
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQBtxQAAoJEELoaioR9I02hjoH/RKfCg0r4nq5AnKDpxJIQEaC
> Cy0QUmLZ812prSDaHgoPBL8ItJ4XiLGmFxwj+F0RXP9sT2QuOsiHYRc3aKk1+X5u
> RMnIuqx4ZdkakeGkTtZMr3ujmy/vOj9NOMuZsigV9z7g/jL5uXzfL0eJcW9kJLQ3
> cNEtdO519q9hInoxpRBkRQtJya1LHoT66oc5AK8TWMBCLjHzvTvvqWNSEBEOfQqH
> b7CulD3x6//DvnlVImA3zFNB2YXLvY6bL3XnU9I/DIEENjG1uAP+9/h+IzWRMNcS
> F0bttSrK9faUqBedMB81hadx0uLjpQxnIB9oFR2NEW/W1J3HAwwVN5YntZFo+lw=
> =BfP8
> -----END PGP SIGNATURE-----
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
