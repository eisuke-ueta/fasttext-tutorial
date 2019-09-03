import fasttext

print("Training model ...")
model = fasttext.train_supervised(input="cooking.train", epoch=25, lr=1.0)

print("Saving model ...")
model.save_model("model_cooking.bin")

print("Validating model ...")
result = model.test("cooking.valid")
print(result)

print("Predicting model ...")
result = model.predict("Which baking dish is best to bake a banana bread ?")
print(result)