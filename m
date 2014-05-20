From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: libbabeltrace: getting CTF sequence length?
Date: Tue, 20 May 2014 16:37:11 -0400
Message-ID: <CAB4xu_1n75_qATZ=Li19VnzGghojAOOQv+U4z9x+qVWHU154vg__11314.2648748637$1400618336$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f53.google.com ([209.85.215.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1WmqnF-0003sG-91
 for lttng-dev@lists.lttng.org; Tue, 20 May 2014 16:37:53 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so866813lab.12
 for <lttng-dev@lists.lttng.org>; Tue, 20 May 2014 13:37:43 -0700 (PDT)
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

Hello,

I'm using libbabeltrace in C++. I would like to know if there's an
equivalent of bt_ctf_get_array_len() for sequences. I tried using
bt_ctf_get_field_list() but the reported count was 10, whereas the
sequence length was really 6 (as shown by the babeltrace tool),
leading to a segfault when accessing the 7th element.

Looking at the Python binding, I see that this is used:

    container_of(field, struct definition_sequence, p);

followed by bt_sequence_len(). However, struct definition_sequence,
bt_sequence_len() (and bt_sequence_index()) are not available in
the API.

So what would be your way to read sequence items? Do you have
an example using strictly what's available in /usr/include/babeltrace?

I'm using the latest Git master on Arch Linux.

Thank you!

Philippe Proulx
