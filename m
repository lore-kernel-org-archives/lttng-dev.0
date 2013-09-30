From: Milosz Tanski <milosz@adfin.com>
Subject: Bulletproof RCU arena resize bug
Date: Mon, 30 Sep 2013 11:16:37 -0400
Message-ID: <CANP1eJFy4Ro4J-_pUtVPp3tm7a9ZoySZe+puJ1YotM=6QhLoOw__45910.8143499636$1380555577$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <milosz@adfin.com>) id 1VQfDI-0003Ab-0O
	for lttng-dev@lists.lttng.org; Mon, 30 Sep 2013 11:16:49 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so5976267wgh.16
	for <lttng-dev@lists.lttng.org>; Mon, 30 Sep 2013 08:16:38 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

While trying to use the BP flavor of RCU I ran into random crashes. I
tracked it down to issues with resizing of the BP RCU memory pool.

The problem is in the urcu-bp.c file in the resize_arena() function.
On successful allocation / remapping the len member of the
registry_arena struct is never set anywhere function. On the second
resize of the arena the code in resize_arena() still thinks the
previous size is equal to the original mapping size. I've fixed this
issue locally by just adding the following code at the bottom of
resize_arena().

I hope this helps,
- Milosz

diff --git a/urcu-bp.c b/urcu-bp.c
index a823659..d26dcc7 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -325,6 +329,7 @@ static void resize_arena(struct registry_arena
*arena, size_t len)

        bzero(new_arena + arena->len, len - arena->len);
        arena->p = new_arena;
+       arena->len = len;
 }

 /* Called with signals off and mutex locked */
