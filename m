From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v6 0/8] Change in compat (e)poll
Date: Tue, 7 May 2019 13:28:41 -0400
Message-ID: <20190507172839.GA15803__44759.9203138211$1557250141$gmane$org@gmail.com>
References: <20190425222334.30349-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by lists.lttng.org (Postfix) with ESMTPS id 44z65m0qCmz1Jpt
 for <lttng-dev@lists.lttng.org>; Tue,  7 May 2019 13:28:43 -0400 (EDT)
Received: by mail-qk1-f193.google.com with SMTP id z6so1106558qkl.10
 for <lttng-dev@lists.lttng.org>; Tue, 07 May 2019 10:28:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190425222334.30349-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

All merged in master and stable-2.11.

I made some minor changes to the messages of the unit tests.

"Fix: lttng_poll_mod calls compat_(e)poll_add" was backported to
stable-2.10.

Thanks!
J=E9r=E9mie

On Thu, Apr 25, 2019 at 06:23:26PM -0400, Yannick Lamarre wrote:
> From v5, fixed compilation problem in unit test and changed the title of =
some
> commits.
> =

> Yannick Lamarre (8):
>   Fix: lttng_poll_mod calls compat_(e)poll_add
>   Add Unit test to poll compatibility layer
>   Change LTTNG_POLL_GETNB behaviour for poll flavor
>   Adapt poll layer behaviour to match the epoll layer
>   Fix: hang in thread_rotation when using compat-poll
>   Change lttng_poll_wait behaviour of compat-poll to match compat-epoll
>   Clean code base from redundant verification
>   Clean-up: correct typo from epoll to poll
> =

>  .gitignore                                   |   1 +
>  src/bin/lttng-consumerd/health-consumerd.c   |   5 -
>  src/bin/lttng-relayd/health-relayd.c         |   5 -
>  src/bin/lttng-relayd/live.c                  |  10 --
>  src/bin/lttng-relayd/main.c                  |  16 --
>  src/bin/lttng-sessiond/agent-thread.c        |   5 -
>  src/bin/lttng-sessiond/client.c              |   5 -
>  src/bin/lttng-sessiond/dispatch.c            |   5 -
>  src/bin/lttng-sessiond/health.c              |   5 -
>  src/bin/lttng-sessiond/ht-cleanup.c          |   5 -
>  src/bin/lttng-sessiond/manage-apps.c         |   5 -
>  src/bin/lttng-sessiond/manage-consumer.c     |  10 --
>  src/bin/lttng-sessiond/manage-kernel.c       |   5 -
>  src/bin/lttng-sessiond/notification-thread.c |   3 -
>  src/bin/lttng-sessiond/notify-apps.c         |   5 -
>  src/bin/lttng-sessiond/register.c            |   5 -
>  src/common/compat/compat-poll.c              |  68 ++++++--
>  src/common/compat/poll.h                     |  10 +-
>  src/common/consumer/consumer.c               |  10 --
>  tests/unit/Makefile.am                       |   9 +-
>  tests/unit/test_utils_compat_poll.c          | 233 +++++++++++++++++++++=
++++++
>  21 files changed, 302 insertions(+), 123 deletions(-)
>  create mode 100644 tests/unit/test_utils_compat_poll.c
> =

> -- =

> 2.11.0
> =
