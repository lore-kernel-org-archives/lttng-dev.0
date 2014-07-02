From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Reusing tracepoint definition with same type of
 arguments but in different order
Date: Wed, 2 Jul 2014 02:09:48 -0400
Message-ID: <CAEEAEzV00Hv1+zA3DgQaU5v+-3myAypoxAds3iAE_dWEZ852xg__12384.8477648155$1404281427$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <babbusandy2006@gmail.com>) id 1X2Dju-0002fl-SM
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 02:09:55 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so4353117qgd.10
 for <lttng-dev@lists.lttng.org>; Tue, 01 Jul 2014 23:09:49 -0700 (PDT)
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

Hi guys,

Is it possible to reuse a tracepoint definition for a different trace
with same type (and number) of arguments but in different order?

Specifically, if I have the arguments in the following order in the definition

        TP_ARGS(
                int, anint,
                long *, values,
                char *, text,
                double, doublearg,
                float, floatarg,
                bool, boolarg
         )

Using some technique, would this definition be directly usable for a
tracepoint with the argument order -  "long *, int, char *, double,
float, bool" or some other order for the matter?

I understand that I can always change the order appropriately
according to the definition in the trace-point insertion but I am
interested in knowing if there is a way to even avoid this. Please let
me know.

Thanks and regards,
Sandeep.
