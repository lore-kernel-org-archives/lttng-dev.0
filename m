From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: [RFC lttng-tools] XML Machine interface
Date: Fri, 20 Jun 2014 10:58:44 -0400
Message-ID: <CAF4oYfFArgVkHUrY=bvwzDCC_ecfDvdq2z5EOLt51+rTzaRWDQ__24656.1758606278$1403276380$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1Wy0HC-0008JW-LG
 for lttng-dev@lists.lttng.org; Fri, 20 Jun 2014 10:58:54 -0400
Received: by mail-yk0-f182.google.com with SMTP id 19so2776718ykq.13
 for <lttng-dev@lists.lttng.org>; Fri, 20 Jun 2014 07:58:44 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

I'd like to submit the following patches from my personal lttng-tools
branch (mi_cherry) for merge in master[1].

28aad7c -  Mi: mi backend + mi for command version
bddf017 -  Mi: add mi support for lttng struct
41da590 -  Mi: support for command list
df7e32c -  Mi: mi xsd validation
b3ef7e9 -  Mi version command: add commit version to mi version
f4314c5 -  Fix: remove extra linking due to add of mi-lttng to libcommon
08a8d16 -  Mi save&load command: support and validation
b434498 -  Mi start command: support and validation
8176e46 -  Mi stop command: support and validation
31523df -  Mi create command: support and validation
465c1a8 -  Mi destroy command: support and validation
7d5be2a -  Mi calibrate command: support and validation
c5a67ea -  Mi add-context command: support and validation
ad5e38c -  Mi enable_channel command: support and validation
2a88c72 -  Mi enable-event command: support for enable-event command
6419e1d -  Mi set-session command: support and validation
ce7ba65 -  Mi disable-event command: support and validation
c5b80e9 -  Mi disable-channel command: support and validation
54a1a6f -  Mi fix: basic formatting

These patches add the ability to output a machine friendly format (XML for now)
to the command line. This can be used to standardize the communication
between lttng-tool CLI and any XML friendly program.
The machine interface is outputted as XML following a schema which is included
in the patches.

Quick user guide to try out this feature:

# add --mi xml between lttng and the normal command
lttng --mi xml list -k
lttng --mi xml create test

# you can also use -m xml
lttng -m xml enable-event -a -k

Looking forward to your comments,

[1] https://github.com/PSRCode/lttng-tools-dev/tree/mi_cherry

-- 
Jonathan Rajotte Julien
