From: Hui Zhu <teawater@gmail.com>
Subject: Request change name of function lookup_enum in libbabeltrace to make GDB use this lib
Date: Wed, 5 Dec 2012 19:37:18 +0800
Message-ID: <CANFwon2s-eJoCrhzJmxhoGx9G2NeOAFf-FDFk1SoxD1OhPxWsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <gdb-return-41616-gdb-gdb=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: gdb@sourceware.org, Tom Tromey <tromey@redhat.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

I am working on add CTF support to GDB.  You can see my patch review threads in:
http://sourceware.org/ml/gdb-patches/2012-11/msg00552.html
http://sourceware.org/ml/gdb-patches/2012-11/msg00554.html
http://sourceware.org/ml/gdb-patches/2012-11/msg00553.html
http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html
http://sourceware.org/ml/gdb-patches/2012-11/msg00556.html

To make GDB support CTF read, I use libbabeltrace with GDB.  You can
see the patch in
http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html.
I have a issue is  libbabeltrace have a function called lookup_enum
that is same with a GDB function.
I change the function name of GDB to handle this issue in my patch.

But Tom said let libbabeltrace to change function name is better.
So I send this mail to ask do you mind change the function name of
lookup_enum?   If you can change the function name that will be really
helpful for us.  Thanks a lot.
And I post a patch about change the function name in libbabeltrace.

Thanks,
Hui

--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -423,7 +423,7 @@ int ctf_read_event(struct stream_pos *pp
 		} else {
 			struct definition_enum *enum_definition;

-			enum_definition = lookup_enum(&stream->stream_event_header->p, "id", FALSE);
+			enum_definition = ctf_lookup_enum(&stream->stream_event_header->p,
"id", FALSE);
 			if (enum_definition) {
 				id = enum_definition->integer->value._unsigned;
 			}
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -513,7 +513,7 @@ struct definition *lookup_definition(con
 struct definition_integer *lookup_integer(const struct definition *definition,
 					  const char *field_name,
 					  int signedness);
-struct definition_enum *lookup_enum(const struct definition *definition,
+struct definition_enum *ctf_lookup_enum(const struct definition *definition,
 				    const char *field_name,
 				    int signedness);
 struct definition *lookup_variant(const struct definition *definition,
--- a/types/types.c
+++ b/types/types.c
@@ -634,7 +634,7 @@ struct definition_integer *lookup_intege
 	return lookup_integer;
 }

-struct definition_enum *lookup_enum(const struct definition *definition,
+struct definition_enum *ctf_lookup_enum(const struct definition *definition,
 				    const char *field_name,
 				    int signedness)
 {
