From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: only cleanup the
 agent_apps_ht_by_sock as root
Date: Thu, 30 Jul 2015 13:40:24 -0400
Message-ID: <55BA6188.2070207__16877.801079727$1438278113$gmane$org@efficios.com>
References: <1438269157-1473-1-git-send-email-jdesfossez@efficios.com>
 <CA+jJMxtq7wLdQnf8QH97hY9=1f5jcs6O9dpKTkghxP5w=FktPQ@mail.gmail.com>
 <CA+jJMxtDov8wEtZp=T3+2LRieRjAcfMQ6WxESgzaw+Gj1KhfKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZKrol-00063R-OH
 for lttng-dev@lists.lttng.org; Thu, 30 Jul 2015 13:40:41 -0400
In-Reply-To: <CA+jJMxtDov8wEtZp=T3+2LRieRjAcfMQ6WxESgzaw+Gj1KhfKw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?windows-1252?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I confirm it fixes the problem I was seeing.

Thanks,

Julien

On 15-07-30 12:53 PM, J=E9r=E9mie Galarneau wrote:
> Here is my proposed fix. Can you test it on your end?
> =

> https://github.com/jgalar/lttng-tools/commits/sessiond-agent-crash
> =

> commit 5e249e09a2bd68f96e546bf83b4710596518f675
> Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com
> <mailto:jeremie.galarneau@efficios.com>>
> Date:   Thu Jul 30 12:48:52 2015 -0400
> =

>     Clean-up: Move agent_apps_ht_by_sock definition to main.c
>     =

>     Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com
> <mailto:jeremie.galarneau@efficios.com>>
> =

> commit 1af8b99faa625033f9e0c2a6eaa9b3006cfadadd
> Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com
> <mailto:jeremie.galarneau@efficios.com>>
> Date:   Thu Jul 30 12:46:56 2015 -0400
> =

>     Fix: Initialize global agent_apps_ht_by_sock on session daemon launch
>     =

>     Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com
> <mailto:jeremie.galarneau@efficios.com>>
> =

> =

> J=E9r=E9mie
> =

> =

> On Thu, Jul 30, 2015 at 12:02 PM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com <mailto:jeremie.galarneau@efficios.com>>
> wrote:
> =

> =

> =

>     On Thu, Jul 30, 2015 at 11:12 AM, Julien Desfossez
>     <jdesfossez@efficios.com <mailto:jdesfossez@efficios.com>> wrote:
> =

>         Commit 6a4e403927ffef4cae8726064dcf53c463eb128c introduced a bug
>         where
>         we could end up iterating over the agent_apps_ht_by_sock
>         regardless if
>         it was allocated or not (only when the sessiond is launched as
>         root).
> =

>         Steps to reproduce:
>         $ sudo lttng-sessiond -d
>         $ lttng-sessiond
>         Error: Already running daemon.
>         Segmentation fault (core dumped)
> =

>         Signed-off-by: Julien Desfossez <jdesfossez@efficios.com
>         <mailto:jdesfossez@efficios.com>>
>         ---
>          src/bin/lttng-sessiond/main.c | 4 +++-
>          1 file changed, 3 insertions(+), 1 deletion(-)
> =

>         diff --git a/src/bin/lttng-sessiond/main.c
>         b/src/bin/lttng-sessiond/main.c
>         index 91dd047..5840165 100644
>         --- a/src/bin/lttng-sessiond/main.c
>         +++ b/src/bin/lttng-sessiond/main.c
>         @@ -677,7 +677,9 @@ static void sessiond_cleanup(void)
>                 }
> =

>                 DBG("Cleaning up all agent apps");
>         -       agent_app_ht_clean();
>         +       if (is_root) {
>         +               agent_app_ht_clean();
>         +       }
> =

> =

>     This will leak the hash table if the session daemon was launched as
>     an unprivileged user. However, the problem can also be reproduced by
>     launching two session daemons under the same unprivileged user.
> =

>     The real issue here seems to be that the session daemon will enter
>     the "exit_init_data" code path before creating the hash table if it
>     can't acquire the lock file and that there are no NULL checks
>     performed during the sessiond_cleanup().
> =

>     Thanks,
>     J=E9r=E9mie
>      =

> =

>                 DBG("Closing all UST sockets");
>                 ust_app_clean_list();
>         --
>         1.9.1
> =

> =

> =

> =

>     -- =

>     J=E9r=E9mie Galarneau
>     EfficiOS Inc.
>     http://www.efficios.com
> =

> =

> =

> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
