From: Sergei Dyshel via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Have live session and rotation together
Date: Mon, 20 Apr 2020 23:17:02 +0300
Message-ID: <CAAeL1MEpwm_HgfJOXfZuoe=f9SbG+uTdcLSUeJAEFe9+hNyc-g@mail.gmail.com>
Reply-To: Sergei Dyshel <qyron.private@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by lists.lttng.org (Postfix) with ESMTPS id 495dK730Zsz1hJh
 for <lttng-dev@lists.lttng.org>; Mon, 20 Apr 2020 16:17:15 -0400 (EDT)
Received: by mail-oo1-xc2e.google.com with SMTP id t12so2042356oot.2
 for <lttng-dev@lists.lttng.org>; Mon, 20 Apr 2020 13:17:15 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

When creating live session (lttng create --live) I can not enable rotation:

# lttng enable-rotation --size=10M
Error: Failed to enable size-based rotation schedule on session BX

In LTTNG 2.12 rotation is supported for network streaming mode  but it
was not yet supported in 2.11.

Is there architectural reasons why we can't have live session with rotation?
Or is it just not implemented yet? In that case in what version is it
expected to appear?
-- 
Regards,
Sergei Dyshel
