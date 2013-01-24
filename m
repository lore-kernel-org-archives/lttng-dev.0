From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 17/18] namespace the definition
	functions
Date: Thu, 24 Jan 2013 16:21:49 -0500
Message-ID: <1359062510-7557-17-git-send-email-jdesfossez__44410.3466267281$1359064787$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFZ-0008GG-EE
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:22 -0500
In-Reply-To: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/events.c       |    4 ++--
 include/babeltrace/types.h |   12 ++++++------
 types/array.c              |   10 +++++-----
 types/enum.c               |    8 ++++----
 types/float.c              |    8 ++++----
 types/integer.c            |    4 ++--
 types/sequence.c           |   12 ++++++------
 types/string.c             |    4 ++--
 types/struct.c             |   10 +++++-----
 types/types.c              |   24 ++++++++++++------------
 types/variant.c            |   12 ++++++------
 11 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index 3660c04..5a6f625 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -106,7 +106,7 @@ const struct definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,
 	if (!ctf_event || !scope || !field)
 		return NULL;
 
-	def = lookup_definition(scope, field);
+	def = bt_lookup_definition(scope, field);
 	/*
 	 * optionally a field can have an underscore prefix, try
 	 * to lookup the field with this prefix if it failed
@@ -115,7 +115,7 @@ const struct definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,
 		field_underscore = g_new(char, strlen(field) + 2);
 		field_underscore[0] = '_';
 		strcpy(&field_underscore[1], field);
-		def = lookup_definition(scope, field_underscore);
+		def = bt_lookup_definition(scope, field_underscore);
 		g_free(field_underscore);
 	}
 	if (bt_ctf_field_type(bt_ctf_get_decl_from_def(def)) == CTF_TYPE_VARIANT) {
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 60bd4fd..f01a11c 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -344,18 +344,18 @@ void bt_free_declaration_scope(struct declaration_scope *scope);
  * definition scopes.
  */
 struct definition *
-	lookup_path_definition(GArray *cur_path,	/* array of GQuark */
+	bt_lookup_path_definition(GArray *cur_path,	/* array of GQuark */
 			       GArray *lookup_path,	/* array of GQuark */
 			       struct definition_scope *scope);
-int register_field_definition(GQuark field_name,
+int bt_register_field_definition(GQuark field_name,
 			      struct definition *definition,
 			      struct definition_scope *scope);
 struct definition_scope *
-	new_definition_scope(struct definition_scope *parent_scope,
+	bt_new_definition_scope(struct definition_scope *parent_scope,
 			     GQuark field_name, const char *root_name);
-void free_definition_scope(struct definition_scope *scope);
+void bt_free_definition_scope(struct definition_scope *scope);
 
-GQuark new_definition_path(struct definition_scope *parent_scope,
+GQuark bt_new_definition_path(struct definition_scope *parent_scope,
 			   GQuark field_name, const char *root_name);
 
 static inline
@@ -516,7 +516,7 @@ void bt_append_scope_path(const char *path, GArray *q);
 /*
  * Lookup helpers.
  */
-struct definition *lookup_definition(const struct definition *definition,
+struct definition *bt_lookup_definition(const struct definition *definition,
 				     const char *field_name);
 struct definition_integer *lookup_integer(const struct definition *definition,
 					  const char *field_name,
diff --git a/types/array.c b/types/array.c
index 7f82167..30699b1 100644
--- a/types/array.c
+++ b/types/array.c
@@ -115,9 +115,9 @@ struct definition *
 	 */
 	array->p.index = root_name ? INT_MAX : index;
 	array->p.name = field_name;
-	array->p.path = new_definition_path(parent_scope, field_name, root_name);
-	array->p.scope = new_definition_scope(parent_scope, field_name, root_name);
-	ret = register_field_definition(field_name, &array->p,
+	array->p.path = bt_new_definition_path(parent_scope, field_name, root_name);
+	array->p.scope = bt_new_definition_scope(parent_scope, field_name, root_name);
+	ret = bt_register_field_definition(field_name, &array->p,
 					parent_scope);
 	assert(!ret);
 	array->string = NULL;
@@ -169,7 +169,7 @@ error:
 		field->declaration->definition_free(field);
 	}
 	(void) g_ptr_array_free(array->elems, TRUE);
-	free_definition_scope(array->p.scope);
+	bt_free_definition_scope(array->p.scope);
 	bt_declaration_unref(array->p.declaration);
 	g_free(array);
 	return NULL;
@@ -193,7 +193,7 @@ void _array_definition_free(struct definition *definition)
 		}
 		(void) g_ptr_array_free(array->elems, TRUE);
 	}
-	free_definition_scope(array->p.scope);
+	bt_free_definition_scope(array->p.scope);
 	bt_declaration_unref(array->p.declaration);
 	g_free(array);
 }
diff --git a/types/enum.c b/types/enum.c
index 6d33713..2c0cfe8 100644
--- a/types/enum.c
+++ b/types/enum.c
@@ -440,10 +440,10 @@ struct definition *
 	 */
 	_enum->p.index = root_name ? INT_MAX : index;
 	_enum->p.name = field_name;
-	_enum->p.path = new_definition_path(parent_scope, field_name, root_name);
-	_enum->p.scope = new_definition_scope(parent_scope, field_name, root_name);
+	_enum->p.path = bt_new_definition_path(parent_scope, field_name, root_name);
+	_enum->p.scope = bt_new_definition_scope(parent_scope, field_name, root_name);
 	_enum->value = NULL;
-	ret = register_field_definition(field_name, &_enum->p,
+	ret = bt_register_field_definition(field_name, &_enum->p,
 					parent_scope);
 	assert(!ret);
 	definition_integer_parent =
@@ -462,7 +462,7 @@ void _enum_definition_free(struct definition *definition)
 		container_of(definition, struct definition_enum, p);
 
 	bt_definition_unref(&_enum->integer->p);
-	free_definition_scope(_enum->p.scope);
+	bt_free_definition_scope(_enum->p.scope);
 	bt_declaration_unref(_enum->p.declaration);
 	if (_enum->value)
 		g_array_unref(_enum->value);
diff --git a/types/float.c b/types/float.c
index 7b89a89..16d4352 100644
--- a/types/float.c
+++ b/types/float.c
@@ -96,8 +96,8 @@ struct definition *
 	bt_declaration_ref(&float_declaration->p);
 	_float->p.declaration = declaration;
 	_float->declaration = float_declaration;
-	_float->p.scope = new_definition_scope(parent_scope, field_name, root_name);
-	_float->p.path = new_definition_path(parent_scope, field_name, root_name);
+	_float->p.scope = bt_new_definition_scope(parent_scope, field_name, root_name);
+	_float->p.path = bt_new_definition_path(parent_scope, field_name, root_name);
 	if (float_declaration->byte_order == LITTLE_ENDIAN) {
 		tmp = float_declaration->mantissa->p.definition_new(&float_declaration->mantissa->p,
 			_float->p.scope, g_quark_from_static_string("mantissa"), 0, NULL);
@@ -130,7 +130,7 @@ struct definition *
 	if (parent_scope) {
 		int ret;
 
-		ret = register_field_definition(field_name, &_float->p,
+		ret = bt_register_field_definition(field_name, &_float->p,
 						parent_scope);
 		assert(!ret);
 	}
@@ -146,7 +146,7 @@ void _float_definition_free(struct definition *definition)
 	bt_definition_unref(&_float->sign->p);
 	bt_definition_unref(&_float->exp->p);
 	bt_definition_unref(&_float->mantissa->p);
-	free_definition_scope(_float->p.scope);
+	bt_free_definition_scope(_float->p.scope);
 	bt_declaration_unref(_float->p.declaration);
 	g_free(_float);
 }
diff --git a/types/integer.c b/types/integer.c
index 936453a..47f23eb 100644
--- a/types/integer.c
+++ b/types/integer.c
@@ -95,11 +95,11 @@ struct definition *
 	 */
 	integer->p.index = root_name ? INT_MAX : index;
 	integer->p.name = field_name;
-	integer->p.path = new_definition_path(parent_scope, field_name,
+	integer->p.path = bt_new_definition_path(parent_scope, field_name,
 					root_name);
 	integer->p.scope = NULL;
 	integer->value._unsigned = 0;
-	ret = register_field_definition(field_name, &integer->p,
+	ret = bt_register_field_definition(field_name, &integer->p,
 					parent_scope);
 	assert(!ret);
 	return &integer->p;
diff --git a/types/sequence.c b/types/sequence.c
index 1795ae4..2646cef 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -148,12 +148,12 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 	 */
 	sequence->p.index = root_name ? INT_MAX : index;
 	sequence->p.name = field_name;
-	sequence->p.path = new_definition_path(parent_scope, field_name, root_name);
-	sequence->p.scope = new_definition_scope(parent_scope, field_name, root_name);
-	ret = register_field_definition(field_name, &sequence->p,
+	sequence->p.path = bt_new_definition_path(parent_scope, field_name, root_name);
+	sequence->p.scope = bt_new_definition_scope(parent_scope, field_name, root_name);
+	ret = bt_register_field_definition(field_name, &sequence->p,
 					parent_scope);
 	assert(!ret);
-	len_parent = lookup_path_definition(sequence->p.scope->scope_path,
+	len_parent = bt_lookup_path_definition(sequence->p.scope->scope_path,
 					    sequence_declaration->length_name,
 					    parent_scope);
 	if (!len_parent) {
@@ -191,7 +191,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 	return &sequence->p;
 
 error:
-	free_definition_scope(sequence->p.scope);
+	bt_free_definition_scope(sequence->p.scope);
 	bt_declaration_unref(&sequence_declaration->p);
 	g_free(sequence);
 	return NULL;
@@ -217,7 +217,7 @@ void _sequence_definition_free(struct definition *definition)
 		(void) g_ptr_array_free(sequence->elems, TRUE);
 	}
 	bt_definition_unref(len_definition);
-	free_definition_scope(sequence->p.scope);
+	bt_free_definition_scope(sequence->p.scope);
 	bt_declaration_unref(sequence->p.declaration);
 	g_free(sequence);
 }
diff --git a/types/string.c b/types/string.c
index 255388f..dff27ee 100644
--- a/types/string.c
+++ b/types/string.c
@@ -86,13 +86,13 @@ struct definition *
 	 */
 	string->p.index = root_name ? INT_MAX : index;
 	string->p.name = field_name;
-	string->p.path = new_definition_path(parent_scope, field_name,
+	string->p.path = bt_new_definition_path(parent_scope, field_name,
 					root_name);
 	string->p.scope = NULL;
 	string->value = NULL;
 	string->len = 0;
 	string->alloc_len = 0;
-	ret = register_field_definition(field_name, &string->p,
+	ret = bt_register_field_definition(field_name, &string->p,
 					parent_scope);
 	assert(!ret);
 	return &string->p;
diff --git a/types/struct.c b/types/struct.c
index 76b82d2..5da9033 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -128,10 +128,10 @@ struct definition *
 	 */
 	_struct->p.index = root_name ? INT_MAX : index;
 	_struct->p.name = field_name;
-	_struct->p.path = new_definition_path(parent_scope, field_name, root_name);
-	_struct->p.scope = new_definition_scope(parent_scope, field_name, root_name);
+	_struct->p.path = bt_new_definition_path(parent_scope, field_name, root_name);
+	_struct->p.scope = bt_new_definition_scope(parent_scope, field_name, root_name);
 
-	ret = register_field_definition(field_name, &_struct->p,
+	ret = bt_register_field_definition(field_name, &_struct->p,
 					parent_scope);
 	assert(!ret || ret == -EPERM);
 
@@ -157,7 +157,7 @@ error:
 		struct definition *field = g_ptr_array_index(_struct->fields, i);
 		bt_definition_unref(field);
 	}
-	free_definition_scope(_struct->p.scope);
+	bt_free_definition_scope(_struct->p.scope);
 	bt_declaration_unref(&struct_declaration->p);
 	g_free(_struct);
 	return NULL;
@@ -175,7 +175,7 @@ void _struct_definition_free(struct definition *definition)
 		struct definition *field = g_ptr_array_index(_struct->fields, i);
 		bt_definition_unref(field);
 	}
-	free_definition_scope(_struct->p.scope);
+	bt_free_definition_scope(_struct->p.scope);
 	bt_declaration_unref(_struct->p.declaration);
 	g_ptr_array_free(_struct->fields, TRUE);
 	g_free(_struct);
diff --git a/types/types.c b/types/types.c
index d60e577..25ce715 100644
--- a/types/types.c
+++ b/types/types.c
@@ -184,7 +184,7 @@ static struct definition_scope *
  * scope: the definition scope containing the variant definition.
  */
 struct definition *
-	lookup_path_definition(GArray *cur_path,
+	bt_lookup_path_definition(GArray *cur_path,
 			       GArray *lookup_path,
 			       struct definition_scope *scope)
 {
@@ -262,7 +262,7 @@ lookup:
 	return NULL;
 }
 
-int register_field_definition(GQuark field_name, struct definition *definition,
+int bt_register_field_definition(GQuark field_name, struct definition *definition,
 		struct definition_scope *scope)
 {
 	if (!scope || !field_name)
@@ -485,7 +485,7 @@ int bt_register_enum_declaration(GQuark enum_name,
 }
 
 static struct definition_scope *
-	_new_definition_scope(struct definition_scope *parent_scope,
+	_bt_new_definition_scope(struct definition_scope *parent_scope,
 			      int scope_path_len)
 {
 	struct definition_scope *scope = g_new(struct definition_scope, 1);
@@ -499,7 +499,7 @@ static struct definition_scope *
 	return scope;
 }
 
-GQuark new_definition_path(struct definition_scope *parent_scope,
+GQuark bt_new_definition_path(struct definition_scope *parent_scope,
 			   GQuark field_name, const char *root_name)
 {
 	GQuark path;
@@ -540,20 +540,20 @@ GQuark new_definition_path(struct definition_scope *parent_scope,
 }
 
 struct definition_scope *
-	new_definition_scope(struct definition_scope *parent_scope,
+	bt_new_definition_scope(struct definition_scope *parent_scope,
 			     GQuark field_name, const char *root_name)
 {
 	struct definition_scope *scope;
 
 	if (root_name) {
-		scope = _new_definition_scope(parent_scope, 0);
+		scope = _bt_new_definition_scope(parent_scope, 0);
 		bt_append_scope_path(root_name, scope->scope_path);
 	} else {
 		int scope_path_len = 1;
 
 		assert(parent_scope);
 		scope_path_len += parent_scope->scope_path->len;
-		scope = _new_definition_scope(parent_scope, scope_path_len);
+		scope = _bt_new_definition_scope(parent_scope, scope_path_len);
 		memcpy(scope->scope_path->data, parent_scope->scope_path->data,
 		       sizeof(GQuark) * (scope_path_len - 1));
 		g_array_index(scope->scope_path, GQuark, scope_path_len - 1) =
@@ -605,14 +605,14 @@ void bt_append_scope_path(const char *path, GArray *q)
 	}
 }
 
-void free_definition_scope(struct definition_scope *scope)
+void bt_free_definition_scope(struct definition_scope *scope)
 {
 	g_array_free(scope->scope_path, TRUE);
 	g_hash_table_destroy(scope->definitions);
 	g_free(scope);
 }
 
-struct definition *lookup_definition(const struct definition *definition,
+struct definition *bt_lookup_definition(const struct definition *definition,
 				     const char *field_name)
 {
 	struct definition_scope *scope = get_definition_scope(definition);
@@ -631,7 +631,7 @@ struct definition_integer *lookup_integer(const struct definition *definition,
 	struct definition *lookup;
 	struct definition_integer *lookup_integer;
 
-	lookup = lookup_definition(definition, field_name);
+	lookup = bt_lookup_definition(definition, field_name);
 	if (!lookup)
 		return NULL;
 	if (lookup->declaration->id != CTF_TYPE_INTEGER)
@@ -649,7 +649,7 @@ struct definition_enum *bt_lookup_enum(const struct definition *definition,
 	struct definition *lookup;
 	struct definition_enum *lookup_enum;
 
-	lookup = lookup_definition(definition, field_name);
+	lookup = bt_lookup_definition(definition, field_name);
 	if (!lookup)
 		return NULL;
 	if (lookup->declaration->id != CTF_TYPE_ENUM)
@@ -666,7 +666,7 @@ struct definition *bt_lookup_variant(const struct definition *definition,
 	struct definition *lookup;
 	struct definition_variant *bt_lookup_variant;
 
-	lookup = lookup_definition(definition, field_name);
+	lookup = bt_lookup_definition(definition, field_name);
 	if (!lookup)
 		return NULL;
 	if (lookup->declaration->id != CTF_TYPE_VARIANT)
diff --git a/types/variant.c b/types/variant.c
index 837875c..ebaf43c 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -195,14 +195,14 @@ struct definition *
 	 */
 	variant->p.index = root_name ? INT_MAX : index;
 	variant->p.name = field_name;
-	variant->p.path = new_definition_path(parent_scope, field_name, root_name);
-	variant->p.scope = new_definition_scope(parent_scope, field_name, root_name);
+	variant->p.path = bt_new_definition_path(parent_scope, field_name, root_name);
+	variant->p.scope = bt_new_definition_scope(parent_scope, field_name, root_name);
 
-	ret = register_field_definition(field_name, &variant->p,
+	ret = bt_register_field_definition(field_name, &variant->p,
 					parent_scope);
 	assert(!ret);
 
-	variant->enum_tag = lookup_path_definition(variant->p.scope->scope_path,
+	variant->enum_tag = bt_lookup_path_definition(variant->p.scope->scope_path,
 						   variant_declaration->tag_name,
 						   parent_scope);
 					      
@@ -232,7 +232,7 @@ struct definition *
 	variant->current_field = NULL;
 	return &variant->p;
 error:
-	free_definition_scope(variant->p.scope);
+	bt_free_definition_scope(variant->p.scope);
 	bt_declaration_unref(&variant_declaration->p);
 	g_free(variant);
 	return NULL;
@@ -251,7 +251,7 @@ void _variant_definition_free(struct definition *definition)
 		bt_definition_unref(field);
 	}
 	bt_definition_unref(variant->enum_tag);
-	free_definition_scope(variant->p.scope);
+	bt_free_definition_scope(variant->p.scope);
 	bt_declaration_unref(variant->p.declaration);
 	g_ptr_array_free(variant->fields, TRUE);
 	g_free(variant);
-- 
1.7.10.4
