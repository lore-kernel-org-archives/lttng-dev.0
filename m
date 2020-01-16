From: Norbert Lange <nolange79@gmail.com>
Subject: liblttng-ust and lttng-tools fail to compile with
 -fno-common
Date: Thu, 16 Jan 2020 16:26:15 +0100
Message-ID: <CADYdroNv4Ak_tkP-bpPz7+SBqoWqnwjkUi46ZjZq5YOpo_QU+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by lists.lttng.org (Postfix) with ESMTPS id 47z7MR5Qfdz1kmx
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jan 2020 10:26:27 -0500 (EST)
Received: by mail-io1-xd2d.google.com with SMTP id n21so22176367ioo.10
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jan 2020 07:26:27 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

The flag -fno-common will cause multiple duplicate symbols, gcc 10
will use this as default, so it will only be a matter of time till you
get some more FTB reports ;)

Norbert
