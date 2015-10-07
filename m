From: Mikael Beckius <mikael.beckius@ericsson.com>
Subject: Re: Sessions are disconnected when disk is full on
 remote host
Date: Wed, 7 Oct 2015 13:50:49 +0000
Message-ID: <FEF43CBBC4664F4D80C53B178C850ADE743C29__22593.7416930266$1444242058$gmane$org@ESESSMB305.ericsson.se>
References: <FEF43CBBC4664F4D80C53B178C850ADE730271@ESESSMB305.ericsson.se>,
 <CA+jJMxsAFJ+MgYYRxhcJUuoyUT8bUWfuiH6WJXSPyVg65zLGWw@mail.gmail.com>,
 <FEF43CBBC4664F4D80C53B178C850ADE7317E3@ESESSMB305.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg22.ericsson.net ([193.180.251.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mikael.beckius@ericsson.com>) id 1Zjp7M-00083e-VQ
 for lttng-dev@lists.lttng.org; Wed, 07 Oct 2015 09:50:54 -0400
In-Reply-To: <FEF43CBBC4664F4D80C53B178C850ADE7317E3@ESESSMB305.ericsson.se>
Content-Language: sv-SE
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

After trying with 2.6.1 and 2.7.0 releases of lttng-tools I cannot say that it makes much of a difference compared with the older versions previously tried. Once the file size for a CPU is reached Babeltrace will output:
[error] get_next_index: error
[error] get_next_index failed

and Babeltrace output from that CPU will cease. Restarting Babeltrace will output some traces again before output  ceases almost immediately and the problem remains until the session has been recreated.

This was with --tracefile-count set to "1" and --tracefile-size of various sizes up to a megabyte BUT if I increase the trace file count to "2" it actually appears to be working.

"LTTng currently doesn't support these recovery modes."
Are there any plans for LTTng to support these "recovery modes" or similar in a future release? Or is there perhaps a way using the LTTng API to detect that a session has lost its connection?

Micke
